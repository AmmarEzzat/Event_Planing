import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/auth/login/login_screen.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/model/my_user.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home_screen/home_screen.dart';
import 'package:evently/ui/home_screen/tabs/profile/profile_tab.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    checkUser();
  }
  Future<void> checkUser() async {

    await Future.delayed(const Duration(seconds: 2));


    if (!mounted) return;

    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) {
      Navigator.pushReplacementNamed(
        context,
        LoginScreen.route,
      );
      return;
    }

    final myUser = await FirebaseUtils.readUserFromFireStore(
      firebaseUser.uid,
    );


    if (myUser != null) {

    }

    if (myUser == null) {


      Navigator.pushReplacementNamed(
        context,
        LoginScreen.route,
      );
      return;
    }

    final userProvider = context.read<UserProvider>();



    userProvider.updateUser(myUser);



    Navigator.pushReplacementNamed(
      context,
      HomeScreen.route,
    );
  }

  @override
  Widget build(BuildContext context) {
    var userProvider=Provider.of<UserProvider>(context);
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