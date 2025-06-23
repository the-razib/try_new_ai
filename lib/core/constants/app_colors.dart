import 'package:flutter/material.dart';

/// App Colors based on Figma design
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF5048E5);
  static const Color primaryLight = Color(0xFF8F87FF);
  
  // Background Colors
  static const Color background = Color(0xFFF8F9FA);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color surfaceGray = Color(0xFFF1F3F4);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);
  
  // Shadow Colors
  static const Color shadow = Color(0x1A000000);
  static const Color cardShadow = Color(0x0F000000);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6C63FF), Color(0xFF8F87FF)],
  );
}  
  // Input Field Colors
  static const Color inputBackground = Color(0xFFF3F4F6);
  static const Color inputBorder = Color(0xFFE5E7EB);
  static const Color inputFocusBorder = Color(0xFF6C63FF);
  
  // Button Colors
  static const Color buttonPrimary = Color(0xFF6C63FF);
  static const Color buttonSecondary = Color(0xFFE5E7EB);
  static const Color buttonDisabled = Color(0xFFD1D5DB);
  
  // Social Colors
  static const Color google = Color(0xFF4285F4);
  static const Color facebook = Color(0xFF1877F2);
  static const Color apple = Color(0xFF000000);
  
  // Status Colors
  static const Color success = Color(0xFF10B981);
