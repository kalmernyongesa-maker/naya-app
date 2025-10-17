import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';

class ComingSoonPage extends ConsumerWidget {
  final String title;
  final String description;
  final IconData icon;

  const ComingSoonPage({
    Key? key,
    required this.title,
    required this.description,
    this.icon = Icons.construction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingXXL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primaryPink.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 60,
                  color: AppColors.primaryPink,
                ),
              ),
              const SizedBox(height: AppDimensions.spacingXXL),

              // Title
              Text(
                'Coming Soon',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.primaryPink,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.spacingM),

              // Description
              Text(
                description,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.spacingXXL),

              // Decorative elements
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDot(),
                  const SizedBox(width: AppDimensions.spacingS),
                  _buildDot(),
                  const SizedBox(width: AppDimensions.spacingS),
                  _buildDot(),
                ],
              ),
              const SizedBox(height: AppDimensions.spacingXL),

              // Back button
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPink,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacingXXL,
                    vertical: AppDimensions.spacingM,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                  ),
                ),
                child: Text(
                  'Go Back',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: AppColors.primaryPink,
        shape: BoxShape.circle,
      ),
    );
  }
}
