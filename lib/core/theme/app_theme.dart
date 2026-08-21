import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Custom Dark Theme tailored for motorcyclists (high contrast, low eye-strain).
class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppConstants.primaryDark,
      primaryColor: AppConstants.accentNeon,
      hintColor: AppConstants.accentNeon,
      cardColor: AppConstants.greyCard,
      
      // Global AppBar Configuration
      appBarTheme: const AppBarTheme(
        backgroundColor: AppConstants.primaryDark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppConstants.titleStyle,
      ),

      // Global Elevated Button Configuration
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.accentNeon,
          foregroundColor: AppConstants.primaryDark,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
