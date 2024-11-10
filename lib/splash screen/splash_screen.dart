import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freedom_app/auth/auth.dart';
import 'package:freedom_app/auth/login_or_register.dart';
import 'package:freedom_app/const.dart';
import 'package:freedom_app/main%20page/main_page.dart';
import 'package:freedom_app/onboarding_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int? isViewed;

  @override
  void initState() {
    super.initState();
    _checkOnboardingViewed();
  }

  // Method to load SharedPreferences and check if onboarding is viewed
  Future<void> _checkOnboardingViewed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    isViewed = prefs.getInt('onBoard');

    // Wait for 2 seconds before navigating to the next screen
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isViewed != 0 ? const OnBoardingScreen() : AuthPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Ensure it takes the full width
        height: double.infinity, // Ensure it takes the full height
        child: Image.asset(
          'assets/logo.jpg',
          fit: BoxFit.cover, // This ensures the image covers the entire screen
        ),
      ),
    );
  }
}
