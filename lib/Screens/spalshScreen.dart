import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  static String id = "SplashScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        duration: 500,
        splashIconSize: 500,
        splash: Image.asset(
          "assets/image/splach.gif",
          fit: BoxFit.contain,
        ),
        nextScreen: HomeScreen(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
