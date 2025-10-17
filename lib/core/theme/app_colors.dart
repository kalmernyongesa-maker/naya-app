import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors (Pink Theme)
  static const Color primaryPink = Color(0xFFF9A8D4);
  static const Color primaryPinkDark = Color(0xFFEC4899);
  static const Color primaryPinkDarker = Color(0xFFDB2777);
  static const Color primaryPinkDarkest = Color(0xFFBE185D);

  // Secondary Colors
  static const Color secondaryPurple = Color(0xFF8B5CF6);
  static const Color secondaryYellow = Color(0xFFFBBF24);
  static const Color secondaryGreen = Color(0xFF10B981);
  static const Color secondaryRed = Color(0xFFEF4444);
  static const Color secondaryBlue = Color(0xFF3B82F6);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF9FAFB);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF1F2937);

  // Text Colors
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryPink, secondaryYellow],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0x12FFFFFF), Color(0x2EFFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadow Colors
  static const Color shadowLight = Color(0x08F9A8D4);
  static const Color shadowMedium = Color(0x18F9A8D4);
  static const Color shadowDark = Color(0x10F9A8D4);

  // Border Colors
  static const Color borderLight = Color(0x18FFFFFF);
  static const Color borderMedium = Color(0x2EFFFFFF);
  static const Color borderDark = Color(0xFFE5E7EB);

  // Rating Colors
  static const Color ratingStar = Color(0xFFFBBF24);
  static const Color ratingEmpty = Color(0xFFE5E7EB);

  // Badge Colors
  static const Color badgeNew = Color(0xFF10B981);
  static const Color badgeDiscount = Color(0xFFEF4444);
  static const Color badgeSale = Color(0xFFF59E0B);

  // Social Media Colors
  static const Color facebook = Color(0xFF1877F2);
  static const Color instagram = Color(0xFFE4405F);
  static const Color twitter = Color(0xFF1DA1F2);
  static const Color youtube = Color(0xFFFF0000);
  static const Color linkedin = Color(0xFF0A66C2);
}
