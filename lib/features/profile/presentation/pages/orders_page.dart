import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';

class OrdersPage extends ConsumerStatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends ConsumerState<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        children: [
          _buildOrderCard(
            orderId: '#NF001',
            date: 'Dec 15, 2024',
            status: 'Delivered',
            total: 'KES 7,850',
            items: ['Vintage Denim Jacket', 'Classic White T-Shirt'],
            statusColor: AppColors.success,
          ),
          const SizedBox(height: AppDimensions.spacingM),
          _buildOrderCard(
            orderId: '#NF002',
            date: 'Dec 10, 2024',
            status: 'Shipped',
            total: 'KES 4,200',
            items: ['Retro High-Waist Jeans'],
            statusColor: AppColors.secondaryBlue,
          ),
          const SizedBox(height: AppDimensions.spacingM),
          _buildOrderCard(
            orderId: '#NF003',
            date: 'Dec 5, 2024',
            status: 'Processing',
            total: 'KES 2,800',
            items: ['Vintage Band T-Shirt', 'Classic Black Jeans'],
            statusColor: AppColors.secondaryYellow,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard({
    required String orderId,
    required String date,
    required String status,
    required String total,
    required List<String> items,
    required Color statusColor,
  }) {
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderId,
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacingS,
                  vertical: AppDimensions.spacingXS,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                ),
                child: Text(
                  status,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacingS),
          Text(
            'Ordered on $date',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingM),
          Text(
            'Items:',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingXS),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: AppDimensions.spacingXS),
                child: Text(
                  '• $item',
                  style: AppTextStyles.bodySmall,
                ),
              )),
          const SizedBox(height: AppDimensions.spacingM),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: $total',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryPink,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Implement order details
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Order details not implemented yet'),
                    ),
                  );
                },
                child: Text(
                  'View Details',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primaryPink,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
