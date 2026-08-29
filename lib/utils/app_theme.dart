import 'package:evently/utils/app_Colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    //scaffoldBackgroundColor: AppColors.primaryLight,
    primaryColor: AppColors.primaryLight,

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      elevation: 50,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryLight,
      foregroundColor: AppColors.whiteColor,
      elevation: 0,
      shape: StadiumBorder(

        side: BorderSide(color: AppColors.whiteColor, width: 8),

      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    // scaffoldBackgroundColor: AppColors.primaryDark,
    primaryColor: AppColors.primaryDark,

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 50,
      showUnselectedLabels: true,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryDark,
      shape: StadiumBorder(side: BorderSide(color: AppColors.whiteColor,width: 4)),
    ),
  );
}
