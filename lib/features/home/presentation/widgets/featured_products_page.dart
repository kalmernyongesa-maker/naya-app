import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/widgets/elevate_card.dart';
import '../../../product/presentation/pages/product_detail_page.dart';

class FeaturedProductsPage extends StatefulWidget {
  const FeaturedProductsPage({Key? key}) : super(key: key);

  @override
  State<FeaturedProductsPage> createState() => _FeaturedProductsPageState();
}

class _FeaturedProductsPageState extends State<FeaturedProductsPage> {
  String _selectedCategory = 'All';
  String _sortBy = 'Popularity';

  final List<String> _categories = [
    'All',
    'Jackets',
    'Dresses',
    'Hoodies',
    'Blazers',
    'Jeans',
  ];

  final List<String> _sortOptions = [
    'Popularity',
    'Price: Low to High',
    'Price: High to Low',
    'Newest',
    'Rating',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Featured Products'),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterBottomSheet,
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _showSortBottomSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 50,
            padding:
                const EdgeInsets.symmetric(vertical: AppDimensions.spacingS),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacingM),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return Container(
                  margin: const EdgeInsets.only(right: AppDimensions.spacingS),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    selectedColor: AppColors.primaryPink.withOpacity(0.2),
                    checkmarkColor: AppColors.primaryPink,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? AppColors.primaryPink
                          : AppColors.textPrimary,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),

          // Products Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(AppDimensions.spacingM),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppDimensions.spacingM,
                mainAxisSpacing: AppDimensions.spacingM,
                childAspectRatio: 0.7,
              ),
              itemCount: _getFeaturedProducts().length,
              itemBuilder: (context, index) {
                final product = _getFeaturedProducts()[index];
                return ElevateCard(
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFeaturedProducts() {
    final allProducts = [
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
      {
        'image':
            'https://images.unsplash.com/photo-1571945153237-4929e783af4a?w=300&h=300&fit=crop',
        'title': 'Warm Knit Sweater',
        'category': 'Jackets',
        'price': 2200.0,
        'oldPrice': 3000.0,
        'rating': 4.4,
        'reviewCount': 56,
        'isNew': true,
        'isOnSale': false,
        'badge': null,
      },
      {
        'image':
            'https://images.unsplash.com/photo-1591195853828-11db59a44f6b?w=300&h=300&fit=crop',
        'title': 'Casual Button Shirt',
        'category': 'Dresses',
        'price': 1500.0,
        'oldPrice': null,
        'rating': 4.2,
        'reviewCount': 78,
        'isNew': false,
        'isOnSale': false,
        'badge': null,
      },
      {
        'image':
            'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?w=300&h=300&fit=crop',
        'title': 'A-Line Midi Skirt',
        'category': 'Dresses',
        'price': 1900.0,
        'oldPrice': 2500.0,
        'rating': 4.5,
        'reviewCount': 42,
        'isNew': false,
        'isOnSale': true,
        'badge': null,
      },
    ];

    if (_selectedCategory == 'All') {
      return allProducts;
    }

    return allProducts
        .where((product) => product['category'] == _selectedCategory)
        .toList();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.radiusXL),
            topRight: Radius.circular(AppDimensions.radiusXL),
          ),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(
                vertical: AppDimensions.spacingM,
              ),
              decoration: BoxDecoration(
                color: AppColors.gray300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacingM,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Filters', style: AppTextStyles.headlineMedium),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = 'All';
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Clear All', style: AppTextStyles.linkText),
                  ),
                ],
              ),
            ),
            const Divider(),
            // Filter Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.spacingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Filter
                    Text('Category', style: AppTextStyles.titleMedium),
                    const SizedBox(height: AppDimensions.spacingM),
                    Wrap(
                      spacing: AppDimensions.spacingS,
                      children: _categories.map((category) {
                        final isSelected = category == _selectedCategory;
                        return FilterChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                          selectedColor: AppColors.primaryPink.withOpacity(0.2),
                          checkmarkColor: AppColors.primaryPink,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppDimensions.spacingXL),

                    // Price Range
                    Text('Price Range', style: AppTextStyles.titleMedium),
                    const SizedBox(height: AppDimensions.spacingM),
                    // Add price range slider here
                    const SizedBox(height: AppDimensions.spacingXL),

                    // Size
                    Text('Size', style: AppTextStyles.titleMedium),
                    const SizedBox(height: AppDimensions.spacingM),
                    // Add size filters here
                    const SizedBox(height: AppDimensions.spacingXL),

                    // Color
                    Text('Color', style: AppTextStyles.titleMedium),
                    const SizedBox(height: AppDimensions.spacingM),
                    // Add color filters here
                  ],
                ),
              ),
            ),
            // Apply Button
            Container(
              padding: const EdgeInsets.all(AppDimensions.spacingM),
              child: SizedBox(
                width: double.infinity,
                height: AppDimensions.buttonHeightL,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Apply Filters', style: AppTextStyles.buttonText),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.radiusXL),
            topRight: Radius.circular(AppDimensions.radiusXL),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(
                vertical: AppDimensions.spacingM,
              ),
              decoration: BoxDecoration(
                color: AppColors.gray300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Text('Sort By', style: AppTextStyles.headlineMedium),
            const SizedBox(height: AppDimensions.spacingM),
            // Sort Options
            ..._sortOptions.map(
              (option) => ListTile(
                title: Text(option),
                trailing: _sortBy == option
                    ? const Icon(Icons.check, color: AppColors.primaryPink)
                    : null,
                onTap: () {
                  setState(() {
                    _sortBy = option;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
          ],
        ),
      ),
    );
  }
}
