import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/widgets/liquid_button.dart';

class AddressesPage extends ConsumerStatefulWidget {
  const AddressesPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AddressesPage> createState() => _AddressesPageState();
}

class _AddressesPageState extends ConsumerState<AddressesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Addresses'),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddAddressDialog();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        children: [
          _buildAddressCard(
            title: 'Home',
            name: 'Naya Fits',
            address: '123 Main Street, Westlands',
            city: 'Nairobi, Kenya',
            phone: '+254 700 000 000',
            isDefault: true,
          ),
          _buildAddressCard(
            title: 'Work',
            name: 'Naya Fits',
            address: '456 Business District, Upper Hill',
            city: 'Nairobi, Kenya',
            phone: '+254 700 000 000',
            isDefault: false,
          ),
          _buildAddressCard(
            title: 'Other',
            name: 'Naya Fits',
            address: '789 Residential Area, Karen',
            city: 'Nairobi, Kenya',
            phone: '+254 700 000 000',
            isDefault: false,
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard({
    required String title,
    required String name,
    required String address,
    required String city,
    required String phone,
    required bool isDefault,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spacingM),
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
            children: [
              Text(
                title,
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (isDefault) ...[
                const SizedBox(width: AppDimensions.spacingS),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacingS,
                    vertical: AppDimensions.spacingXS,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryPink,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  ),
                  child: Text(
                    'DEFAULT',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              const Spacer(),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    _showEditAddressDialog();
                  } else if (value == 'delete') {
                    _showDeleteAddressDialog();
                  } else if (value == 'default') {
                    _setAsDefault();
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem(
                    value: 'default',
                    child: Text('Set as Default'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                ],
                child: const Icon(Icons.more_vert),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacingM),
          Text(
            name,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingXS),
          Text(
            address,
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: AppDimensions.spacingXS),
          Text(
            city,
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: AppDimensions.spacingXS),
          Text(
            phone,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  void _showAddAddressDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Address'),
        content: const Text('Address management functionality coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showEditAddressDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Address'),
        content: const Text('Address editing functionality coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAddressDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Address'),
        content: const Text('Are you sure you want to delete this address?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Address deleted successfully'),
                ),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _setAsDefault() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Default address updated successfully'),
      ),
    );
  }
}
