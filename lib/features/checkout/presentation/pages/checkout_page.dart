import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/widgets/liquid_button.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentStep = 0;

  final List<String> _steps = ['Shipping', 'Payment', 'Review'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _steps.length, vsync: this);
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
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: AppColors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingM,
            ),
            child: Column(
              children: [
                // Progress Indicator
                Row(
                  children: List.generate(_steps.length, (index) {
                    final isActive = index <= _currentStep;
                    final isCompleted = index < _currentStep;

                    return Expanded(
                      child: Row(
                        children: [
                          // Step Circle
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColors.primaryPink
                                  : AppColors.gray200,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: isCompleted
                                  ? const Icon(
                                      Icons.check,
                                      color: AppColors.white,
                                      size: 16,
                                    )
                                  : Text(
                                      '${index + 1}',
                                      style: AppTextStyles.labelMedium.copyWith(
                                        color: isActive
                                            ? AppColors.white
                                            : AppColors.textLight,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                          // Connector Line
                          if (index < _steps.length - 1)
                            Expanded(
                              child: Container(
                                height: 2,
                                color: index < _currentStep
                                    ? AppColors.primaryPink
                                    : AppColors.gray200,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: AppDimensions.spacingS,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ),
                const SizedBox(height: AppDimensions.spacingS),
                // Step Labels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _steps.map((step) {
                    final index = _steps.indexOf(step);
                    final isActive = index <= _currentStep;

                    return Text(
                      step,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isActive
                            ? AppColors.primaryPink
                            : AppColors.textLight,
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildShippingStep(),
                _buildPaymentStep(),
                _buildReviewStep(),
              ],
            ),
          ),

          // Bottom Actions
          Container(
            padding: const EdgeInsets.all(AppDimensions.spacingM),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowLight.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousStep,
                      child: const Text('Back'),
                    ),
                  ),
                if (_currentStep > 0)
                  const SizedBox(width: AppDimensions.spacingM),
                Expanded(
                  flex: 2,
                  child: LiquidButton(
                    text: _currentStep == _steps.length - 1
                        ? 'Place Order'
                        : 'Continue',
                    icon: _currentStep == _steps.length - 1
                        ? Icons.shopping_cart
                        : Icons.arrow_forward,
                    onPressed: _nextStep,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shipping Address
          _buildSection(
            title: 'Shipping Address',
            child: Column(
              children: [
                _buildTextField('Full Name', 'John Doe'),
                const SizedBox(height: AppDimensions.spacingM),
                _buildTextField('Phone Number', '+254 700 000 000'),
                const SizedBox(height: AppDimensions.spacingM),
                _buildTextField('Address', '123 Main Street'),
                const SizedBox(height: AppDimensions.spacingM),
                Row(
                  children: [
                    Expanded(child: _buildTextField('City', 'Nairobi')),
                    const SizedBox(width: AppDimensions.spacingM),
                    Expanded(child: _buildTextField('Postal Code', '00100')),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.spacingL),

          // Delivery Options
          _buildSection(
            title: 'Delivery Options',
            child: Column(
              children: [
                _buildDeliveryOption(
                  title: 'Standard Delivery',
                  subtitle: '5-7 business days',
                  price: 'KES 200',
                  isSelected: true,
                ),
                const SizedBox(height: AppDimensions.spacingM),
                _buildDeliveryOption(
                  title: 'Express Delivery',
                  subtitle: '2-3 business days',
                  price: 'KES 500',
                  isSelected: false,
                ),
                const SizedBox(height: AppDimensions.spacingM),
                _buildDeliveryOption(
                  title: 'Same Day Delivery',
                  subtitle: 'Within Nairobi',
                  price: 'KES 800',
                  isSelected: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Payment Methods
          _buildSection(
            title: 'Payment Method',
            child: Column(
              children: [
                _buildPaymentOption(
                  title: 'M-Pesa',
                  subtitle: 'Pay with your M-Pesa account',
                  icon: Icons.phone_android,
                  isSelected: true,
                ),
                const SizedBox(height: AppDimensions.spacingM),
                _buildPaymentOption(
                  title: 'Stripe',
                  subtitle: 'Pay with card',
                  icon: Icons.credit_card,
                  isSelected: false,
                ),
                const SizedBox(height: AppDimensions.spacingM),
                _buildPaymentOption(
                  title: 'Cash on Delivery',
                  subtitle: 'Pay when you receive your order',
                  icon: Icons.money,
                  isSelected: false,
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.spacingL),

          // Order Summary
          _buildSection(
            title: 'Order Summary',
            child: Column(
              children: [
                _buildSummaryRow('Subtotal', 'KES 7,500'),
                _buildSummaryRow('Shipping', 'KES 200'),
                _buildSummaryRow('Tax', 'KES 150'),
                const Divider(),
                _buildSummaryRow('Total', 'KES 7,850', isTotal: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Items
          _buildSection(
            title: 'Order Items',
            child: Column(
              children: List.generate(3, (index) {
                return _buildOrderItem(index);
              }),
            ),
          ),

          const SizedBox(height: AppDimensions.spacingL),

          // Shipping Details
          _buildSection(
            title: 'Shipping Details',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('John Doe', style: AppTextStyles.bodyMedium),
                Text('+254 700 000 000', style: AppTextStyles.bodySmall),
                Text(
                  '123 Main Street, Nairobi 00100',
                  style: AppTextStyles.bodySmall,
                ),
                const SizedBox(height: AppDimensions.spacingS),
                Text(
                  'Standard Delivery - KES 200',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.spacingL),

          // Payment Details
          _buildSection(
            title: 'Payment Details',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('M-Pesa Payment', style: AppTextStyles.bodyMedium),
                Text(
                  'You will receive an M-Pesa prompt',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
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
          Text(title, style: AppTextStyles.titleMedium),
          const SizedBox(height: AppDimensions.spacingM),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
      ),
    );
  }

  Widget _buildDeliveryOption({
    required String title,
    required String subtitle,
    required String price,
    required bool isSelected,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            // Update selection
          });
        },
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.spacingM),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? AppColors.primaryPink : AppColors.gray200,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          child: Row(
            children: [
              Radio<bool>(
                value: isSelected,
                groupValue: true,
                onChanged: (value) {
                  setState(() {
                    // Update selection
                  });
                },
                activeColor: AppColors.primaryPink,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.bodyMedium),
                    Text(subtitle, style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
              Text(price, style: AppTextStyles.priceTextSmall),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            // Update selection
          });
        },
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.spacingM),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? AppColors.primaryPink : AppColors.gray200,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          child: Row(
            children: [
              Radio<bool>(
                value: isSelected,
                groupValue: true,
                onChanged: (value) {
                  setState(() {
                    // Update selection
                  });
                },
                activeColor: AppColors.primaryPink,
              ),
              const SizedBox(width: AppDimensions.spacingM),
              Icon(icon, color: AppColors.primaryPink),
              const SizedBox(width: AppDimensions.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.bodyMedium),
                    Text(subtitle, style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItem(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spacingM),
      padding: const EdgeInsets.all(AppDimensions.spacingM),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray200),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              color: AppColors.gray100,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              child: Image.network(
                'https://picsum.photos/60/60?random=$index',
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Product ${index + 1}', style: AppTextStyles.bodyMedium),
                Text('Size: M', style: AppTextStyles.bodySmall),
                Text('Qty: 1', style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Text(
            'KES ${(1000 + index * 500).toStringAsFixed(0)}',
            style: AppTextStyles.priceTextSmall,
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
            style: isTotal
                ? AppTextStyles.titleMedium
                : AppTextStyles.bodyMedium,
          ),
          Text(
            value,
            style: isTotal ? AppTextStyles.priceText : AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });
      _tabController.animateTo(_currentStep);
    } else {
      // Place order
      _showOrderConfirmation();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _tabController.animateTo(_currentStep);
    }
  }

  void _showOrderConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: AppColors.success,
                size: 40,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            Text('Order Placed!', style: AppTextStyles.headlineSmall),
            const SizedBox(height: AppDimensions.spacingS),
            Text(
              'Your order has been placed successfully. You will receive a confirmation email shortly.',
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: LiquidButton(
              text: 'Continue Shopping',
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}



