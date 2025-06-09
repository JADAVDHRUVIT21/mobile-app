class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Carousel Section
              CarouselSection(),

              const SizedBox(height: 20),

              // Dashboard Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: [
                    // Lists Tile
                    DashboardTile(
                      title: 'Lists',
                      subtitle: '3 lists',
                      icon: Icons.note,
                      color: Colors.amber,
                    ),

                    // Calendar Tile
                    DashboardTile(
                      title: 'Calendar',
                      subtitle: '2 events today',
                      icon: Icons.calendar_today,
                      color: Colors.purple,
                      showNotification: true,
                    ),

                    // Meal Planner Tile
                    DashboardTile(
                      title: 'Meal Planner',
                      subtitle: 'Start your meal plan for the week',
                      icon: Icons.restaurant_menu,
                      color: Colors.orange,
                    ),

                    // Timetable Tile
                    DashboardTile(
                      title: 'Timetable',
                      subtitle: 'Schedule your day',
                      icon: Icons.schedule,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Carousel Section Widget
class CarouselSection extends StatefulWidget {
  @override
  _CarouselSectionState createState() => _CarouselSectionState();
}

class _CarouselSectionState extends State<CarouselSection> {
  final List<String> titles = [
    'Welcome Dhruvit, let\'s invite members to your circle',
    'Explore new recipes today!',
    'Your diet tracker is waiting',
    'Shop smart with suggestions'
  ];

  final List<String> imageUrls = [
    'https://picsum.photos/id/1015/400/300',
    'https://picsum.photos/id/1018/400/300',
    'https://picsum.photos/id/1020/400/300',
    'https://picsum.photos/id/1024/400/300',
  ];

  static const int _initialPage = 1000;
  late PageController _pageController;
  double _currentPage = _initialPage.toDouble();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _initialPage,
      viewportFraction: 0.75,
    );

    _pageController.addListener(() {
      setState(() => _currentPage = _pageController.page ?? _initialPage.toDouble());
    });

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      int nextPage = _pageController.page!.toInt() + 1;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildDotsIndicator() {
    int currentIndex = _currentPage.round() % titles.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(titles.length, (index) {
        bool isActive = currentIndex == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 12 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? Colors.green : Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              final int actualIndex = index % titles.length;
              double difference = (_currentPage - index).abs();
              double scale = 1 - (difference * 0.08).clamp(0.0, 0.08);
              double translateY = 15 * difference.clamp(0.0, 1.0);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Transform.translate(
                  offset: Offset(0, translateY),
                  child: Transform.scale(
                    scale: scale,
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              imageUrls[actualIndex],
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  color: Colors.grey[300],
                                  child: const Center(child: CircularProgressIndicator()),
                                );
                              },
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey,
                                child: const Icon(Icons.broken_image, size: 40),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.35),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                titles[actualIndex],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        _buildDotsIndicator(),
      ],
    );
  }
}

// Dashboard Tile Widget
class DashboardTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool showNotification;

  const DashboardTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.showNotification = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Icon(icon, color: color),
                      if (showNotification)
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
