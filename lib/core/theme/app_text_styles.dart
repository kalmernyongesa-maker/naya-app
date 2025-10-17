import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Display Styles
  static TextStyle get displayLarge => GoogleFonts.figtree(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle get displayMedium => GoogleFonts.figtree(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle get displaySmall => GoogleFonts.figtree(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Headline Styles
  static TextStyle get headlineLarge => GoogleFonts.figtree(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get headlineMedium => GoogleFonts.figtree(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get headlineSmall => GoogleFonts.figtree(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Title Styles
  static TextStyle get titleLarge => GoogleFonts.figtree(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get titleMedium => GoogleFonts.figtree(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get titleSmall => GoogleFonts.figtree(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Body Styles
  static TextStyle get bodyLarge => GoogleFonts.figtree(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle get bodyMedium => GoogleFonts.figtree(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle get bodySmall => GoogleFonts.figtree(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // Label Styles
  static TextStyle get labelLarge => GoogleFonts.figtree(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get labelMedium => GoogleFonts.figtree(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static TextStyle get labelSmall => GoogleFonts.figtree(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textLight,
    height: 1.4,
  );

  // Custom Styles for App
  static TextStyle get buttonText => GoogleFonts.figtree(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    height: 1.2,
  );

  static TextStyle get buttonTextSecondary => GoogleFonts.figtree(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryPink,
    height: 1.2,
  );

  static TextStyle get priceText => GoogleFonts.figtree(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryPink,
    height: 1.2,
  );

  static TextStyle get priceTextSmall => GoogleFonts.figtree(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryPink,
    height: 1.2,
  );

  static TextStyle get oldPriceText => GoogleFonts.figtree(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
    decoration: TextDecoration.lineThrough,
    height: 1.2,
  );

  static TextStyle get categoryText => GoogleFonts.figtree(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textLight,
    letterSpacing: 0.5,
    height: 1.2,
  );

  static TextStyle get ratingText => GoogleFonts.figtree(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.ratingStar,
    height: 1.2,
  );

  static TextStyle get badgeText => GoogleFonts.figtree(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0.5,
    height: 1.0,
  );

  static TextStyle get navText => GoogleFonts.figtree(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle get navTextSelected => GoogleFonts.figtree(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryPink,
    height: 1.2,
  );

  static TextStyle get searchHint => GoogleFonts.figtree(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
    height: 1.4,
  );

  static TextStyle get errorText => GoogleFonts.figtree(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.error,
    height: 1.4,
  );

  static TextStyle get successText => GoogleFonts.figtree(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.success,
    height: 1.4,
  );

  static TextStyle get linkText => GoogleFonts.figtree(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryPink,
    decoration: TextDecoration.underline,
    height: 1.4,
  );

  // Hero Section Styles
  static TextStyle get heroTitle => GoogleFonts.figtree(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.1,
  );

  static TextStyle get heroSubtitle => GoogleFonts.figtree(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // Product Card Styles
  static TextStyle get productTitle => GoogleFonts.figtree(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get productCategory => GoogleFonts.figtree(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textLight,
    letterSpacing: 0.5,
    height: 1.2,
  );

  // Admin Styles
  static TextStyle get adminTitle => GoogleFonts.figtree(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle get adminSubtitle => GoogleFonts.figtree(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get metricValue => GoogleFonts.figtree(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.1,
  );

  static TextStyle get metricLabel => GoogleFonts.figtree(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  static TextStyle get metricGrowth => GoogleFonts.figtree(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.success,
    height: 1.2,
  );
}

