import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/widgets/elevate_card.dart';
import '../../../product/presentation/pages/product_detail_page.dart';
import 'featured_products_page.dart';

class FeaturedProductsSection extends StatelessWidget {
  const FeaturedProductsSection({Key? key}) : super(key: key);

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
              Text('Featured Products', style: AppTextStyles.headlineMedium),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FeaturedProductsPage(),
                    ),
                  );
                },
                child: Text('View All', style: AppTextStyles.linkText),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacingM),

          // Products Grid
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Mock data
              itemBuilder: (context, index) {
                final featuredProducts = [
                  {
                    'image':
                        'https://images.unsplash.com/photo-1544022613-e87ca75a784a?w=300&h=300&fit=crop',
                    'title': 'Vintage Denim Jacket',
                    'category': 'Jackets',
                    'price': 2500.0,
                    'oldPrice': 3500.0,
                    'rating': 4.5,
                    'reviewCount': 23,
                    'isNew': true,
                    'isOnSale': false,
                    'badge': null,
                  },
                  {
                    'image':
                        'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?w=300&h=300&fit=crop',
                    'title': 'Elegant Floral Dress',
                    'category': 'Dresses',
                    'price': 3200.0,
                    'oldPrice': 4500.0,
                    'rating': 4.8,
                    'reviewCount': 45,
                    'isNew': false,
                    'isOnSale': true,
                    'badge': null,
                  },
                  {
                    'image':
                        'https://images.unsplash.com/photo-1503341504253-dff4815485f1?w=300&h=300&fit=crop',
                    'title': 'Cozy Oversized Hoodie',
                    'category': 'Hoodies',
                    'price': 1800.0,
                    'oldPrice': null,
                    'rating': 4.3,
                    'reviewCount': 67,
                    'isNew': false,
                    'isOnSale': false,
                    'badge': 'TRENDING',
                  },
                  {
                    'image':
                        'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=300&h=300&fit=crop',
                    'title': 'Professional Blazer',
                    'category': 'Blazers',
                    'price': 4200.0,
                    'oldPrice': 5500.0,
                    'rating': 4.7,
                    'reviewCount': 34,
                    'isNew': false,
                    'isOnSale': true,
                    'badge': null,
                  },
                  {
                    'image':
                        'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=300&h=300&fit=crop',
                    'title': 'Retro High-Waist Jeans',
                    'category': 'Jeans',
                    'price': 2800.0,
                    'oldPrice': 3800.0,
                    'rating': 4.6,
                    'reviewCount': 89,
                    'isNew': false,
                    'isOnSale': true,
                    'badge': null,
                  },
                ];

                final product = featuredProducts[index];

                return Container(
                  width: 200,
                  margin: const EdgeInsets.only(right: AppDimensions.spacingM),
                  child: ElevateCard(
                    imageUrl: product['image'] as String,
                    title: product['title'] as String,
                    category: product['category'] as String,
                    price: product['price'] as double,
                    oldPrice: product['oldPrice'] as double?,
                    rating: product['rating'] as double,
                    reviewCount: product['reviewCount'] as int,
                    isNew: product['isNew'] as bool,
                    isOnSale: product['isOnSale'] as bool,
                    badge: product['badge'] as String?,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            productId: 'featured_$index',
                            productName: product['title'] as String,
                            productImage: product['image'] as String,
                            price: product['price'] as double,
                            oldPrice: product['oldPrice'] as double?,
                            category: product['category'] as String,
                            rating: product['rating'] as double,
                            reviewCount: product['reviewCount'] as int,
                            isNew: product['isNew'] as bool,
                            isOnSale: product['isOnSale'] as bool,
                            badge: product['badge'] as String?,
                          ),
                        ),
                      );
                    },
                    onWishlistTap: () {
                      // Toggle wishlist
                    },
                    onAddToCart: () {
                      // Add to cart
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
