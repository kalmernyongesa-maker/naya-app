import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/widgets/elevate_card.dart';
import '../../../../core/widgets/search_bar.dart';
import '../../../product/presentation/pages/product_detail_page.dart';

class ShopPage extends ConsumerStatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends ConsumerState<ShopPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _sortBy = 'Popularity';

  final List<String> _categories = [
    'All',
    'Women',
    'Men',
    'Kids',
    'Accessories',
    'Shoes',
    'Bags',
  ];

  final List<String> _sortOptions = [
    'Popularity',
    'Price: Low to High',
    'Price: High to Low',
    'Newest',
    'Rating',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120,
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
                child: Column(
                  children: [
                    // Top Bar
                    Row(
                      children: [
                        Text('Shop', style: AppTextStyles.headlineMedium),
                        const Spacer(),
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
                    const SizedBox(height: AppDimensions.spacingM),
                    // Search Bar
                    CustomSearchBar(
                      controller: _searchController,
                      hintText: 'Search products...',
                      onChanged: (value) {
                        // Handle search
                      },
                      onSubmitted: (value) {
                        // Handle search submission
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Category Tabs
          SliverPersistentHeader(
            pinned: true,
            delegate: _CategoryTabDelegate(
              TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: AppColors.primaryPink,
                labelColor: AppColors.primaryPink,
                unselectedLabelColor: AppColors.textLight,
                labelStyle: AppTextStyles.labelMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: AppTextStyles.labelMedium,
                tabs:
                    _categories.map((category) => Tab(text: category)).toList(),
                onTap: (index) {
                  setState(() {
                    _selectedCategory = _categories[index];
                  });
                },
              ),
            ),
          ),

          // Products Grid
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
                  final productImages = [
                    'https://images.unsplash.com/photo-1544022613-e87ca75a784a?w=300&h=300&fit=crop', // Denim Jacket
                    'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=300&h=300&fit=crop', // White T-shirt
                    'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=300&h=300&fit=crop', // Jeans
                    'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?w=300&h=300&fit=crop', // Dress
                    'https://images.unsplash.com/photo-1503341504253-dff4815485f1?w=300&h=300&fit=crop', // Hoodie
                    'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=300&h=300&fit=crop', // Blazer
                    'https://images.unsplash.com/photo-1571945153237-4929e783af4a?w=300&h=300&fit=crop', // Sweater
                    'https://images.unsplash.com/photo-1591195853828-11db59a44f6b?w=300&h=300&fit=crop', // Shirt
                    'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?w=300&h=300&fit=crop', // Skirt
                    'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=300&h=300&fit=crop', // Coat
                    'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=300&fit=crop', // Jumpsuit
                    'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?w=300&h=300&fit=crop', // Maxi Dress
                    'https://images.unsplash.com/photo-1503341504253-dff4815485f1?w=300&h=300&fit=crop', // Cardigan
                    'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=300&h=300&fit=crop', // Trench Coat
                    'https://images.unsplash.com/photo-1571945153237-4929e783af4a?w=300&h=300&fit=crop', // Knit Top
                    'https://images.unsplash.com/photo-1591195853828-11db59a44f6b?w=300&h=300&fit=crop', // Polo Shirt
                    'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?w=300&h=300&fit=crop', // Mini Skirt
                    'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=300&h=300&fit=crop', // Winter Jacket
                    'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=300&fit=crop', // Romper
                    'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?w=300&h=300&fit=crop', // Summer Dress
                  ];

                  final productNames = [
                    'Vintage Denim Jacket',
                    'Classic White T-Shirt',
                    'Retro High-Waist Jeans',
                    'Elegant Floral Dress',
                    'Cozy Oversized Hoodie',
                    'Professional Blazer',
                    'Warm Knit Sweater',
                    'Casual Button Shirt',
                    'A-Line Midi Skirt',
                    'Classic Trench Coat',
                    'Trendy Jumpsuit',
                    'Maxi Summer Dress',
                    'Soft Cardigan',
                    'Stylish Trench Coat',
                    'Comfortable Knit Top',
                    'Polo Shirt',
                    'Mini Skirt',
                    'Winter Puffer Jacket',
                    'Summer Romper',
                    'Floral Maxi Dress',
                  ];

                  return ElevateCard(
                    imageUrl: productImages[index % productImages.length],
                    title: productNames[index % productNames.length],
                    category: _selectedCategory,
                    price: 1000.0 + (index * 500),
                    oldPrice: index % 3 == 0 ? 1500.0 + (index * 500) : null,
                    rating: 3.5 + (index % 2),
                    reviewCount: 10 + index,
                    isNew: index % 5 == 0,
                    isOnSale: index % 3 == 0,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            productId: 'shop_$index',
                            productName:
                                productNames[index % productNames.length],
                            productImage:
                                productImages[index % productImages.length],
                            price: 1000.0 + (index * 500),
                            oldPrice:
                                index % 3 == 0 ? 1500.0 + (index * 500) : null,
                            category: _selectedCategory,
                            rating: 3.5 + (index % 2),
                            reviewCount: 10 + index,
                            isNew: index % 5 == 0,
                            isOnSale: index % 3 == 0,
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
                childCount: 20, // Mock data
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _FilterBottomSheet(),
    );
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _SortBottomSheet(
        currentSort: _sortBy,
        onSortSelected: (sort) {
          setState(() {
            _sortBy = sort;
          });
        },
      ),
    );
  }
}

class _CategoryTabDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _CategoryTabDelegate(this.tabBar);

  @override
  double get minExtent => 48;

  @override
  double get maxExtent => 48;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColors.white, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class _FilterBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    // Clear all filters
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
                  const SizedBox(height: AppDimensions.spacingXL),

                  // Brand
                  Text('Brand', style: AppTextStyles.titleMedium),
                  const SizedBox(height: AppDimensions.spacingM),
                  // Add brand filters here
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
    );
  }
}

class _SortBottomSheet extends StatelessWidget {
  final String currentSort;
  final ValueChanged<String> onSortSelected;

  const _SortBottomSheet({
    required this.currentSort,
    required this.onSortSelected,
  });

  @override
  Widget build(BuildContext context) {
    final sortOptions = [
      'Popularity',
      'Price: Low to High',
      'Price: High to Low',
      'Newest',
      'Rating',
    ];

    return Container(
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
          ...sortOptions.map(
            (option) => ListTile(
              title: Text(option),
              trailing: currentSort == option
                  ? const Icon(Icons.check, color: AppColors.primaryPink)
                  : null,
              onTap: () {
                onSortSelected(option);
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(height: AppDimensions.spacingM),
        ],
      ),
    );
  }
}
