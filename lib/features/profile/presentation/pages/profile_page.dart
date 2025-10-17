import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import 'personal_info_page.dart';
import 'orders_page.dart';
import 'addresses_page.dart';
import 'coming_soon_page.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content:
            const Text('Are you sure you want to sign out of your account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ComingSoonPage(
                    title: 'Sign Out',
                    description:
                        'You have been signed out successfully. Thank you for using Nayafits!',
                    icon: Icons.logout,
                  ),
                ),
              );
            },
            child: const Text('Sign Out'),
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
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primaryPink,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primaryPink, AppColors.primaryPinkDark],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.spacingM),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Profile Avatar
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: AppColors.white,
                          child: const Icon(
                            Icons.person,
                            size: 48,
                            color: AppColors.primaryPink,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spacingM),
                        Text(
                          'Naya Fits',
                          style: AppTextStyles.headlineMedium.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spacingXS),
                        Text(
                          'test@gmail.com',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Profile Menu
          SliverList(
            delegate: SliverChildListDelegate([
              _buildMenuSection('Account', [
                _buildMenuItem(
                  icon: Icons.person_outline,
                  title: 'Personal Information',
                  subtitle: 'Update your profile details',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PersonalInfoPage(),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.location_on_outlined,
                  title: 'Addresses',
                  subtitle: 'Manage your delivery addresses',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddressesPage(),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.payment_outlined,
                  title: 'Payment Methods',
                  subtitle: 'Manage your payment options',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComingSoonPage(
                          title: 'Payment Methods',
                          description:
                              'Manage your payment options and saved cards',
                          icon: Icons.payment,
                        ),
                      ),
                    );
                  },
                ),
              ]),
              _buildMenuSection('Orders', [
                _buildMenuItem(
                  icon: Icons.shopping_bag_outlined,
                  title: 'My Orders',
                  subtitle: 'View your order history',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrdersPage(),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.local_shipping_outlined,
                  title: 'Track Orders',
                  subtitle: 'Track your current orders',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComingSoonPage(
                          title: 'Track Orders',
                          description:
                              'Track your current orders and delivery status',
                          icon: Icons.local_shipping,
                        ),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.rate_review_outlined,
                  title: 'Reviews',
                  subtitle: 'Rate and review products',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComingSoonPage(
                          title: 'Reviews',
                          description:
                              'Rate and review products you\'ve purchased',
                          icon: Icons.rate_review,
                        ),
                      ),
                    );
                  },
                ),
              ]),
              _buildMenuSection('Support', [
                _buildMenuItem(
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  subtitle: 'Get help and support',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComingSoonPage(
                          title: 'Help Center',
                          description:
                              'Get help and support for your questions',
                          icon: Icons.help,
                        ),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.contact_support_outlined,
                  title: 'Contact Us',
                  subtitle: 'Get in touch with us',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComingSoonPage(
                          title: 'Contact Us',
                          description: 'Get in touch with our support team',
                          icon: Icons.contact_support,
                        ),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.info_outline,
                  title: 'About',
                  subtitle: 'Learn more about Nayafits',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComingSoonPage(
                          title: 'About Nayafits',
                          description:
                              'Learn more about our mission and values',
                          icon: Icons.info,
                        ),
                      ),
                    );
                  },
                ),
              ]),
              _buildMenuSection('Settings', [
                _buildMenuItem(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  subtitle: 'Manage your notifications',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComingSoonPage(
                          title: 'Notifications',
                          description: 'Manage your notification preferences',
                          icon: Icons.notifications,
                        ),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  subtitle: 'Read our privacy policy',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComingSoonPage(
                          title: 'Privacy Policy',
                          description:
                              'Read our privacy policy and terms of service',
                          icon: Icons.privacy_tip,
                        ),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.logout,
                  title: 'Sign Out',
                  subtitle: 'Sign out of your account',
                  onTap: () {
                    _showSignOutDialog();
                  },
                  isDestructive: true,
                ),
              ]),
              const SizedBox(height: AppDimensions.spacingXXL),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Container(
      margin: const EdgeInsets.all(AppDimensions.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingS),
          Container(
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
            child: Column(children: items),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.spacingM),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDestructive
                      ? AppColors.error.withOpacity(0.1)
                      : AppColors.primaryPink.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
                child: Icon(
                  icon,
                  color:
                      isDestructive ? AppColors.error : AppColors.primaryPink,
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
                        fontWeight: FontWeight.w500,
                        color: isDestructive
                            ? AppColors.error
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacingXS),
                    Text(subtitle, style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.textLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
