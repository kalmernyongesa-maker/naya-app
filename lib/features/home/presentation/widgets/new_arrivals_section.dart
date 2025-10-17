import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/widgets/elevate_card.dart';

class NewArrivalsSection extends StatelessWidget {
  const NewArrivalsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDimensions.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('New Arrivals', style: AppTextStyles.headlineMedium),
              TextButton(
                onPressed: () {
                  // Navigate to all new arrivals
                },
                child: Text('View All', style: AppTextStyles.linkText),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacingM),

          // Products Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppDimensions.spacingM,
              mainAxisSpacing: AppDimensions.spacingM,
              childAspectRatio: 0.7,
            ),
            itemCount: 4, // Mock data
            itemBuilder: (context, index) {
              return ElevateCard(
                imageUrl: 'https://picsum.photos/200/200?random=${index + 10}',
                title: 'Designer Handbag',
                category: 'Bags',
                price: 4500.0,
                oldPrice: 6000.0,
                rating: 4.8,
                reviewCount: 15,
                isNew: true,
                onTap: () {
                  // Navigate to product detail
                },
                onWishlistTap: () {
                  // Toggle wishlist
                },
                onAddToCart: () {
                  // Add to cart
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

