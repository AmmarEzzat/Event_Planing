import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  void changeTheme(ThemeMode newTheme) {
    if (ThemeMode == newTheme) {
      return;
    }

    appTheme = newTheme;
    notifyListeners();
  }
}
