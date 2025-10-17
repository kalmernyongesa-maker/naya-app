import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/widgets/liquid_button.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final double? oldPrice;
  final String category;
  final double rating;
  final int reviewCount;
  final bool isNew;
  final bool isOnSale;
  final String? badge;

  const ProductDetailPage({
    Key? key,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    this.oldPrice,
    required this.category,
    required this.rating,
    required this.reviewCount,
    this.isNew = false,
    this.isOnSale = false,
    this.badge,
  }) : super(key: key);

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedSize = 'M';
  int _quantity = 1;
  bool _isWishlisted = false;

  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 400,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  _isWishlisted ? Icons.favorite : Icons.favorite_border,
                  color: _isWishlisted ? AppColors.error : AppColors.white,
                ),
                onPressed: () {
                  setState(() {
                    _isWishlisted = !_isWishlisted;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.share, color: AppColors.white),
                onPressed: () {
                  // Share functionality
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.productImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.gray100,
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 100,
                          color: AppColors.gray400,
                        ),
                      );
                    },
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                  // Badges
                  Positioned(
                    top: 100,
                    left: AppDimensions.spacingM,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.isNew)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.spacingS,
                              vertical: AppDimensions.spacingXS,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.badgeNew,
                              borderRadius:
                                  BorderRadius.circular(AppDimensions.radiusS),
                            ),
                            child: Text(
                              'NEW',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (widget.isOnSale)
                          Container(
                            margin: const EdgeInsets.only(
                                top: AppDimensions.spacingXS),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.spacingS,
                              vertical: AppDimensions.spacingXS,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.badgeSale,
                              borderRadius:
                                  BorderRadius.circular(AppDimensions.radiusS),
                            ),
                            child: Text(
                              'SALE',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (widget.badge != null)
                          Container(
                            margin: const EdgeInsets.only(
                                top: AppDimensions.spacingXS),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.spacingS,
                              vertical: AppDimensions.spacingXS,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryPink,
                              borderRadius:
                                  BorderRadius.circular(AppDimensions.radiusS),
                            ),
                            child: Text(
                              widget.badge!,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Product Info
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(AppDimensions.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name and Category
                  Text(
                    widget.productName,
                    style: AppTextStyles.headlineMedium,
                  ),
                  const SizedBox(height: AppDimensions.spacingXS),
                  Text(
                    widget.category,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingM),

                  // Rating
                  Row(
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < widget.rating.floor()
                                ? Icons.star
                                : Icons.star_border,
                            color: AppColors.ratingStar,
                            size: 16,
                          );
                        }),
                      ),
                      const SizedBox(width: AppDimensions.spacingXS),
                      Text(
                        '${widget.rating} (${widget.reviewCount} reviews)',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spacingM),

                  // Price
                  Row(
                    children: [
                      Text(
                        'KES ${widget.price.toStringAsFixed(0)}',
                        style: AppTextStyles.headlineMedium.copyWith(
                          color: AppColors.primaryPink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (widget.oldPrice != null) ...[
                        const SizedBox(width: AppDimensions.spacingS),
                        Text(
                          'KES ${widget.oldPrice!.toStringAsFixed(0)}',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.textLight,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spacingXL),

                  // Size Selection
                  Text(
                    'Size',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingM),
                  Wrap(
                    spacing: AppDimensions.spacingS,
                    children: _sizes.map((size) {
                      final isSelected = size == _selectedSize;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSize = size;
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryPink
                                : AppColors.white,
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryPink
                                  : AppColors.gray200,
                              width: 2,
                            ),
                            borderRadius:
                                BorderRadius.circular(AppDimensions.radiusM),
                          ),
                          child: Center(
                            child: Text(
                              size,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: isSelected
                                    ? AppColors.white
                                    : AppColors.textPrimary,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppDimensions.spacingXL),

                  // Quantity Selection
                  Row(
                    children: [
                      Text(
                        'Quantity',
                        style: AppTextStyles.titleMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.gray200),
                          borderRadius:
                              BorderRadius.circular(AppDimensions.radiusM),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: _quantity > 1
                                  ? () {
                                      setState(() {
                                        _quantity--;
                                      });
                                    }
                                  : null,
                            ),
                            Text(
                              '$_quantity',
                              style: AppTextStyles.titleMedium,
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  _quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spacingXL),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: LiquidButton(
                          text: 'Add to Cart',
                          icon: Icons.shopping_cart,
                          onPressed: () {
                            // Add to cart functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('${widget.productName} added to cart'),
                                backgroundColor: AppColors.success,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spacingM),
                      Expanded(
                        child: LiquidButton(
                          text: 'Buy Now',
                          icon: Icons.flash_on,
                          onPressed: () {
                            // Buy now functionality
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Product Details Tabs
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.white,
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    indicatorColor: AppColors.primaryPink,
                    labelColor: AppColors.primaryPink,
                    unselectedLabelColor: AppColors.textLight,
                    tabs: const [
                      Tab(text: 'Description'),
                      Tab(text: 'Reviews'),
                      Tab(text: 'Shipping'),
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildDescriptionTab(),
                        _buildReviewsTab(),
                        _buildShippingTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionTab() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Description',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingM),
          Text(
            'This beautiful ${widget.productName.toLowerCase()} is perfect for any occasion. Made from high-quality materials, it offers both comfort and style. The vintage-inspired design adds a unique touch to your wardrobe while maintaining modern functionality.',
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: AppDimensions.spacingM),
          Text(
            'Features:',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingS),
          const Text('• High-quality materials'),
          const Text('• Comfortable fit'),
          const Text('• Easy care instructions'),
          const Text('• Sustainable fashion choice'),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Reviews',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingM),
          _buildReviewItem(
            name: 'Sarah M.',
            rating: 5,
            comment:
                'Absolutely love this item! Great quality and perfect fit.',
            date: '2 days ago',
          ),
          _buildReviewItem(
            name: 'John D.',
            rating: 4,
            comment: 'Good quality for the price. Would recommend.',
            date: '1 week ago',
          ),
          _buildReviewItem(
            name: 'Emma L.',
            rating: 5,
            comment: 'Fast shipping and exactly as described. Very happy!',
            date: '2 weeks ago',
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem({
    required String name,
    required int rating,
    required String comment,
    required String date,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spacingM),
      padding: const EdgeInsets.all(AppDimensions.spacingM),
      decoration: BoxDecoration(
        color: AppColors.gray50,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: AppColors.ratingStar,
                    size: 16,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacingS),
          Text(
            comment,
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: AppDimensions.spacingS),
          Text(
            date,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingTab() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping Information',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingM),
          _buildShippingInfo(
            icon: Icons.local_shipping,
            title: 'Standard Shipping',
            description: '5-7 business days',
            price: 'KES 200',
          ),
          _buildShippingInfo(
            icon: Icons.flash_on,
            title: 'Express Shipping',
            description: '2-3 business days',
            price: 'KES 500',
          ),
          _buildShippingInfo(
            icon: Icons.store,
            title: 'Store Pickup',
            description: 'Available at our Nairobi store',
            price: 'Free',
          ),
        ],
      ),
    );
  }

  Widget _buildShippingInfo({
    required IconData icon,
    required String title,
    required String description,
    required String price,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spacingM),
      padding: const EdgeInsets.all(AppDimensions.spacingM),
      decoration: BoxDecoration(
        color: AppColors.gray50,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primaryPink,
            size: 24,
          ),
          const SizedBox(width: AppDimensions.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primaryPink,
            ),
          ),
        ],
      ),
    );
  }
}
