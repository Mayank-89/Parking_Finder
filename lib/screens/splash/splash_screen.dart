import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const Icon(
        Icons.local_parking,
        size: 120,
        color: Colors.white,
      ),
      nextScreen: const LoginScreen(),
      splashIconSize: 150,
      backgroundColor: Colors.green,
      duration: 3000,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}