
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/splash_screen.dart';
import 'package:evently/ui/home_screen/home_screen.dart';
import 'package:evently/utils/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      initialRoute: Splash.route,
      routes: {
        Splash.route: (context) => const Splash(),
        HomeScreen.route:(context)=>HomeScreen(),

      },

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
