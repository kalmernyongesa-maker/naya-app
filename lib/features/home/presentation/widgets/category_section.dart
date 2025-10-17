import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Women', 'icon': Icons.woman, 'color': AppColors.primaryPink},
      {'name': 'Men', 'icon': Icons.man, 'color': AppColors.secondaryPurple},
      {
        'name': 'Kids',
        'icon': Icons.child_care,
        'color': AppColors.secondaryGreen,
      },
      {
        'name': 'Accessories',
        'icon': Icons.watch,
        'color': AppColors.secondaryYellow,
      },
      {
        'name': 'Shoes',
        'icon': Icons.shopping_bag,
        'color': AppColors.secondaryRed,
      },
      {
        'name': 'Bags',
        'icon': Icons.shopping_bag_outlined,
        'color': AppColors.primaryPinkDark,
      },
    ];

    return Container(
      margin: const EdgeInsets.all(AppDimensions.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Shop by Category', style: AppTextStyles.headlineMedium),
          const SizedBox(height: AppDimensions.spacingM),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppDimensions.spacingM,
              mainAxisSpacing: AppDimensions.spacingM,
              childAspectRatio: 1.0,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return _buildCategoryCard(
                name: category['name'] as String,
                icon: category['icon'] as IconData,
                color: category['color'] as Color,
                onTap: () {
                  // Navigate to category
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required String name,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: AppDimensions.spacingS),
              Text(
                name,
                style: AppTextStyles.labelMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

