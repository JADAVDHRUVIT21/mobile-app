import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page UI',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE7F6),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: 400,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Family Connect App',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 30),
                _buildInputField(
                  icon: Icons.person_outline,
                  hint: 'Username',
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  icon: Icons.lock_outline,
                  hint: 'Password',
                  obscure: true,
                ),
                const SizedBox(height: 24),
                _buildGradientButton(),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[300])),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' with Others'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey[300])),
                  ],
                ),
                const SizedBox(height: 20),
                _buildSocialButton(
                  label: 'Login with Google',
                  iconWidget: Image.network(
                    'https://imagepng.org/wp-content/uploads/2019/08/google-icon-1.png',
                    width: 20,
                    height: 20,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildInputField({
    required IconData icon,
    required String hint,
    bool obscure = false,
  }) {
    return TextFormField(
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF3F1FF),
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  static Widget _buildGradientButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6A5AE0), Color(0xFF9273E8)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 6),
            blurRadius: 8,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Login ',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }

  static Widget _buildSocialButton({
    required String label,
    required Widget iconWidget,
  }) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: iconWidget,
      label: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
