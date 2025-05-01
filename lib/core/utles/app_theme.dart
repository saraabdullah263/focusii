import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_colors.dart';

class AppTheme {
  static ThemeData ligthTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: Colors.white,
      secondary: Colors.black,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.red,
      surface: Colors.red,
      onSurface: Colors.red,
    ),
    
  );
}
