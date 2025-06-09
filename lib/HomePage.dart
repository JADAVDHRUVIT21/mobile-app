import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: BottomNavScreen(),
    );
  }
}

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    CalendarPage(),
    MealPlanPage(),
    ShoppingPage(),
    AccountPage(),
  ];

  final List<String> _titles = [
    "Home",
    "Calendar",
    "Meal Plan",
    "Shopping",
    "Account",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.account_circle_rounded),
          onPressed: () => setState(() => _currentIndex = 4),
        ),
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: _currentIndex != 4
          ? BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Meal Plan'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Shopping'),
        ],
      )
          : null,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  static const int _initialPage = 1000; // start somewhere in the middle
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
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: SizedBox(
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
        ),
        const SizedBox(height: 12),
        _buildDotsIndicator(),
      ],
    );
  }
}

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(child: Text('Calendar Page'));
}

class MealPlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(child: Text('Meal Plan Page'));
}

class ShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(child: Text('Shopping Page'));
}

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(child: Text('Account Page'));
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Page')),
    );
  }
}
