import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/widgets/elevate_card.dart';
import '../../../../core/widgets/liquid_button.dart';
import '../../../../core/widgets/search_bar.dart';
import '../../../navigation/presentation/pages/main_navigation_page.dart';
import '../widgets/hero_section.dart';
import '../widgets/category_section.dart';
import '../widgets/featured_products_section.dart';
import '../widgets/new_arrivals_section.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showNotificationsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
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
                  Text('Notifications', style: AppTextStyles.headlineMedium),
                  TextButton(
                    onPressed: () {
                      // Mark all as read
                    },
                    child: Text('Mark all read', style: AppTextStyles.linkText),
                  ),
                ],
              ),
            ),
            const Divider(),
            // Notifications List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppDimensions.spacingM),
                children: [
                  _buildNotificationItem(
                    icon: Icons.shopping_bag,
                    title: 'New Arrivals!',
                    message: 'Check out our latest collection of vintage items',
                    time: '2 hours ago',
                    isUnread: true,
                  ),
                  _buildNotificationItem(
                    icon: Icons.local_shipping,
                    title: 'Order Shipped',
                    message:
                        'Your order #NF001 has been shipped and is on its way',
                    time: '1 day ago',
                    isUnread: true,
                  ),
                  _buildNotificationItem(
                    icon: Icons.discount,
                    title: 'Special Offer',
                    message: 'Get 20% off on all jackets this weekend only!',
                    time: '2 days ago',
                    isUnread: false,
                  ),
                  _buildNotificationItem(
                    icon: Icons.favorite,
                    title: 'Wishlist Reminder',
                    message:
                        'The Vintage Denim Jacket you liked is back in stock',
                    time: '3 days ago',
                    isUnread: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String message,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spacingM),
      padding: const EdgeInsets.all(AppDimensions.spacingM),
      decoration: BoxDecoration(
        color: isUnread
            ? AppColors.primaryPink.withOpacity(0.05)
            : AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(
          color: isUnread
              ? AppColors.primaryPink.withOpacity(0.2)
              : AppColors.gray200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryPink.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryPink,
              size: 20,
            ),
          ),
          const SizedBox(width: AppDimensions.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: isUnread ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingXS),
                Text(
                  message,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingXS),
                Text(
                  time,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          if (isUnread)
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primaryPink,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
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
                        // Logo
                        Text(
                          'Nayafits',
                          style: AppTextStyles.headlineMedium.copyWith(
                            color: AppColors.primaryPink,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        // Notifications
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined),
                          onPressed: () {
                            _showNotificationsBottomSheet(context);
                          },
                        ),
                        // Profile
                        GestureDetector(
                          onTap: () {
                            // Navigate to profile page (index 4)
                            final ref = ProviderScope.containerOf(context);
                            ref.read(navigationIndexProvider.notifier).state =
                                4;
                          },
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.primaryPink,
                            child: const Icon(
                              Icons.person,
                              color: AppColors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.spacingM),
                    // Search Bar
                    CustomSearchBar(
                      hintText: 'Search products, brands, categories...',
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

          // Hero Section
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: const HeroSection(),
                  ),
                );
              },
            ),
          ),

          // Categories Section
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: const CategorySection(),
                  ),
                );
              },
            ),
          ),

          // Featured Products Section
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: const FeaturedProductsSection(),
                  ),
                );
              },
            ),
          ),

          // New Arrivals Section
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: const NewArrivalsSection(),
                  ),
                );
              },
            ),
          ),

          // Bottom Spacing
          const SliverToBoxAdapter(
            child: SizedBox(height: AppDimensions.spacingXXL),
          ),
        ],
      ),
    );
  }
}
