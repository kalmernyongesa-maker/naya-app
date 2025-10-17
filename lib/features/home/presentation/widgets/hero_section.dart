import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/widgets/liquid_button.dart';
import '../../../navigation/presentation/pages/main_navigation_page.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _particleController;
  late AnimationController _floatingController;
  late AnimationController _textController;

  @override
  void initState() {
    super.initState();

    _particleController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    );

    _floatingController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _particleController.repeat();
    _floatingController.repeat();
    _textController.forward();
  }

  @override
  void dispose() {
    _particleController.dispose();
    _floatingController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.heroMinHeight,
      margin: const EdgeInsets.all(AppDimensions.spacingM),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight.withOpacity(0.1),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Pattern
          _buildBackgroundPattern(),

          // Floating Particles
          _buildFloatingParticles(),

          // Floating Elements
          _buildFloatingElements(),

          // Content
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildBackgroundPattern() {
    return Positioned.fill(child: CustomPaint(painter: GridPatternPainter()));
  }

  Widget _buildFloatingParticles() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return Stack(
          children: List.generate(8, (index) {
            final delay = index * 0.125;
            final progress = (_particleController.value + delay) % 1.0;

            return Positioned(
              left: (index + 1) * 12.5,
              bottom: progress * MediaQuery.of(context).size.height,
              child: Transform.rotate(
                angle: progress * 6.28,
                child: Container(
                  width: 4 + (index % 3),
                  height: 4 + (index % 3),
                  decoration: BoxDecoration(
                    color: AppColors.primaryPink.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildFloatingElements() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Stack(
          children: [
            // T-shirt
            Positioned(
              top: 60,
              left: 40,
              child: Transform.rotate(
                angle: _floatingController.value * 6.28,
                child: Icon(
                  Icons.checkroom,
                  size: 32,
                  color: AppColors.primaryPink.withOpacity(0.1),
                ),
              ),
            ),
            // Dress
            Positioned(
              top: 120,
              right: 60,
              child: Transform.rotate(
                angle: -_floatingController.value * 6.28,
                child: Icon(
                  Icons.woman,
                  size: 28,
                  color: AppColors.secondaryYellow.withOpacity(0.1),
                ),
              ),
            ),
            // Pants
            Positioned(
              bottom: 100,
              left: 80,
              child: Transform.rotate(
                angle: _floatingController.value * 3.14,
                child: Icon(
                  Icons.accessibility_new,
                  size: 24,
                  color: AppColors.secondaryGreen.withOpacity(0.1),
                ),
              ),
            ),
            // Hat
            Positioned(
              bottom: 80,
              right: 40,
              child: Transform.rotate(
                angle: -_floatingController.value * 4.71,
                child: Icon(
                  Icons.sports_baseball,
                  size: 20,
                  color: AppColors.secondaryPurple.withOpacity(0.1),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContent() {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _textController,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _textController,
                curve: Curves.easeOutCubic,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.spacingXXL),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Premium Thrift\nFashion',
                    style: AppTextStyles.heroTitle,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: AppDimensions.spacingM),
                  Text(
                    'Discover unique, high-quality second-hand clothing and accessories at affordable prices.',
                    style: AppTextStyles.heroSubtitle,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: AppDimensions.spacingXL),
                  Wrap(
                    spacing: AppDimensions.spacingM,
                    runSpacing: AppDimensions.spacingM,
                    children: [
                      LiquidButton(
                        text: 'Shop Now',
                        icon: Icons.shopping_bag,
                        onPressed: () {
                          // Navigate to shop page (index 1)
                          final context = this.context;
                          final ref = ProviderScope.containerOf(context);
                          ref.read(navigationIndexProvider.notifier).state = 1;
                        },
                      ),
                      LiquidButton(
                        text: 'Learn More',
                        isSecondary: true,
                        icon: Icons.info_outline,
                        onPressed: () {
                          // Show about dialog
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('About Nayafits'),
                              content: const Text(
                                'Nayafits is your premier destination for premium thrift fashion. We offer unique, high-quality second-hand clothing and accessories at affordable prices, helping you build a sustainable and stylish wardrobe.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Close'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.gray200.withOpacity(0.3)
      ..strokeWidth = 0.5;

    const gridSize = 20.0;

    // Draw vertical lines
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal lines
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
