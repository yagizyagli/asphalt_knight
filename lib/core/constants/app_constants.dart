import 'package:flutter/material.dart';

/// Global constants for the Asphalt Knight ecosystem (Supports Motor & Car).
class AppConstants {
  // Technical Thresholds for Motorcycle
  static const double crashThresholdMotorG = 8.0; // High impact / tilt
  
  // Technical Thresholds for Car
  static const double crashThresholdCarG = 5.0; // Massive deceleration (Head-on crash)

  static const int countdownDurationSeconds = 15;

  // Design System & Branding Colors
  static const Color primaryDark = Color(0xFF121212);    
  static const Color accentNeon = Color(0xFF00FFCC);     // Cyan for Motor
  static const Color accentCarBlue = Color(0xFF0099FF);  // Electric Blue for Car
  static const Color emergencyRed = Color(0xFFFF3333);   
  static const Color textLight = Color(0xFFF5F5F5);      
  static const Color greyCard = Color(0xFF1E1E1E);       
}
