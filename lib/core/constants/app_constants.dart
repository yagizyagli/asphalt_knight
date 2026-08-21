import 'package:flutter/material.dart';

/// Global constants for the Asphalt Knight ecosystem.
class AppConstants {
  // Technical Thresholds
  static const double crashThresholdG = 8.0;
  static const int countdownDurationSeconds = 15;

  // Design System & Branding Colors (Knight Theme)
  static const Color primaryDark = Color(0xFF121212);    // Deep Asphalt Black
  static const Color accentNeon = Color(0xFF00FFCC);     // Cyberpunk Shield Cyan
  static const Color emergencyRed = Color(0xFFFF3333);   // SOS Alert Red
  static const Color textLight = Color(0xFFF5F5F5);      // Clean White Text
  static const Color greyCard = Color(0xFF1E1E1E);       // Dark Dashboard Gray

  // Typography Styles
  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textLight,
    letterSpacing: 1.2,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: textLight,
  );
}
