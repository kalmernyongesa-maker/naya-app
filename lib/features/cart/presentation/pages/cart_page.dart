import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/widgets/liquid_button.dart';
import '../../data/providers/cart_provider.dart';
import '../../data/models/cart_item.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

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
                    Text('Shopping Cart', style: AppTextStyles.headlineMedium),
                    const Spacer(),
                    if (cartItems.isNotEmpty)
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Clear Cart'),
                              content: const Text(
                                  'Are you sure you want to clear all items from your cart?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    cartNotifier.clearCart();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Clear'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text('Clear All', style: AppTextStyles.linkText),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Cart Items
          if (cartItems.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                      color: AppColors.gray400,
                    ),
                    const SizedBox(height: AppDimensions.spacingM),
                    Text(
                      'Your cart is empty',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.gray400,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacingS),
                    Text(
                      'Add some items to get started',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.gray400,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildCartItem(cartItems[index], cartNotifier);
                },
                childCount: cartItems.length,
              ),
            ),

          // Order Summary
          if (cartItems.isNotEmpty)
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(AppDimensions.spacingM),
                padding: const EdgeInsets.all(AppDimensions.spacingM),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Summary', style: AppTextStyles.titleLarge),
                    const SizedBox(height: AppDimensions.spacingM),
                    _buildSummaryRow('Subtotal',
                        'KES ${cartNotifier.subtotal.toStringAsFixed(0)}'),
                    _buildSummaryRow('Shipping',
                        'KES ${cartNotifier.shipping.toStringAsFixed(0)}'),
                    _buildSummaryRow(
                        'Tax', 'KES ${cartNotifier.tax.toStringAsFixed(0)}'),
                    const Divider(),
                    _buildSummaryRow('Total',
                        'KES ${cartNotifier.grandTotal.toStringAsFixed(0)}',
                        isTotal: true),
                    const SizedBox(height: AppDimensions.spacingM),
                    SizedBox(
                      width: double.infinity,
                      child: LiquidButton(
                        text: 'Proceed to Checkout',
                        icon: Icons.shopping_cart,
                        onPressed: () async {
                          const url = 'https://nayafits.com/checkout';
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url),
                                mode: LaunchMode.externalApplication);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Could not open checkout page'),
                              ),
                            );
                          }
                        },
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

  Widget _buildCartItem(CartItem item, CartNotifier cartNotifier) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingM,
        vertical: AppDimensions.spacingS,
      ),
      padding: const EdgeInsets.all(AppDimensions.spacingM),
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
      child: Row(
        children: [
          // Product Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              color: AppColors.gray100,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported,
                    color: AppColors.gray400,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.spacingM),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: AppTextStyles.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppDimensions.spacingXS),
                Text('Size: ${item.size}', style: AppTextStyles.bodySmall),
                const SizedBox(height: AppDimensions.spacingXS),
                Text(
                  'KES ${item.price.toStringAsFixed(0)}',
                  style: AppTextStyles.priceText,
                ),
              ],
            ),
          ),

          // Quantity and Actions
          Column(
            children: [
              // Quantity Controls
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.gray200),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 16),
                      onPressed: () {
                        cartNotifier.updateQuantity(item.id, item.quantity - 1);
                      },
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                    ),
                    Text('${item.quantity}', style: AppTextStyles.bodyMedium),
                    IconButton(
                      icon: const Icon(Icons.add, size: 16),
                      onPressed: () {
                        cartNotifier.updateQuantity(item.id, item.quantity + 1);
                      },
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.spacingS),

              // Remove Button
              TextButton(
                onPressed: () {
                  cartNotifier.removeItem(item.id);
                },
                child: Text(
                  'Remove',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingXS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style:
                isTotal ? AppTextStyles.titleMedium : AppTextStyles.bodyMedium,
          ),
          Text(
            value,
            style: isTotal ? AppTextStyles.priceText : AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}
