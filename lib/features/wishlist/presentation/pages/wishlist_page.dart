import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/widgets/elevate_card.dart';

class WishlistPage extends ConsumerStatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  ConsumerState<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends ConsumerState<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 100,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.white,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.fromLTRB(
                  AppDimensions.spacingM,
                  AppDimensions.spacingXL,
                  AppDimensions.spacingM,
                  AppDimensions.spacingM,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text('My Wishlist', style: AppTextStyles.headlineMedium),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        // Share wishlist
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Wishlist Content
          SliverPadding(
            padding: const EdgeInsets.all(AppDimensions.spacingM),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppDimensions.spacingM,
                mainAxisSpacing: AppDimensions.spacingM,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ElevateCard(
                    imageUrl: 'https://picsum.photos/200/200?random=$index',
                    title: 'Wishlist Item ${index + 1}',
                    category: 'Category',
                    price: 1000.0 + (index * 500),
                    oldPrice: index % 3 == 0 ? 1500.0 + (index * 500) : null,
                    rating: 3.5 + (index % 2),
                    reviewCount: 10 + index,
                    isWishlisted: true,
                    onTap: () {
                      // Navigate to product detail
                    },
                    onWishlistTap: () {
                      // Remove from wishlist
                    },
                    onAddToCart: () {
                      // Add to cart
                    },
                  );
                },
                childCount: 8, // Mock data
              ),
            ),
          ),
        ],
      ),
    );
  }
}



