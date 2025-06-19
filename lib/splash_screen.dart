// splash_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kppmining_calculator/ui/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => const HomePage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/png/splash.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
