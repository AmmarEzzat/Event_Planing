import 'dart:async';
import 'package:evently/ui/home_screen/home_screen.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  static const String route="Splash";
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splash> {
  bool isDark = false;

  @override
  void initState() {
    super.initState();


    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
      isDark ? const Color(0xFF101127) : const Color(0xFFF2FEFF),
      body: Stack(
        children: [

          Center(
            child: Image.asset(
              AppAssets.SplashScreen,
              width: 180,
              height: 180,
              fit: BoxFit.contain,
            ),
          ),


          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Image.asset(
              AppAssets.Pranding,
              width: 120,
              height: 120,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}