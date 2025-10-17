import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_dimensions.dart';

class LiquidButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isSecondary;
  final bool isLoading;
  final IconData? icon;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool enabled;

  const LiquidButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isSecondary = false,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height,
    this.padding,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<LiquidButton> createState() => _LiquidButtonState();
}

class _LiquidButtonState extends State<LiquidButton>
    with TickerProviderStateMixin {
  late AnimationController _fillController;
  late AnimationController _particleController;
  late AnimationController _hoverController;

  late Animation<double> _fillAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _translateAnimation;

  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    _fillController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fillAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fillController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );

    _translateAnimation = Tween<double>(begin: 0.0, end: -2.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fillController.dispose();
    _particleController.dispose();
    _hoverController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _fillController.forward();
      _hoverController.forward();
      _particleController.repeat();
    } else {
      _fillController.reverse();
      _hoverController.reverse();
      _particleController.stop();
    }
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.enabled && !widget.isLoading ? widget.onPressed : null,
        child: AnimatedBuilder(
          animation: Listenable.merge([_fillController, _hoverController]),
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _translateAnimation.value),
              child: Transform.scale(
                scale: _isPressed ? 0.95 : _scaleAnimation.value,
                child: Container(
                  width: widget.width ?? AppDimensions.liquidButtonMinWidth,
                  height: widget.height ?? AppDimensions.liquidButtonHeight,
                  decoration: BoxDecoration(
                    color: widget.isSecondary
                        ? AppColors.primaryPink
                        : AppColors.white,
                    border: Border.all(color: AppColors.primaryPink, width: 2),
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusRound,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowMedium.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Liquid Fill Effect
                      AnimatedBuilder(
                        animation: _fillAnimation,
                        builder: (context, child) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusRound,
                              ),
                              gradient: LinearGradient(
                                colors: widget.isSecondary
                                    ? [AppColors.white, AppColors.white]
                                    : [
                                        AppColors.primaryPink,
                                        AppColors.primaryPink,
                                      ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [0.0, _fillAnimation.value],
                              ),
                            ),
                          );
                        },
                      ),

                      // Floating Particles
                      if (_isHovered) _buildParticles(),

                      // Button Content
                      Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: TextStyle(
                            color: _isHovered
                                ? (widget.isSecondary
                                      ? AppColors.primaryPink
                                      : AppColors.white)
                                : (widget.isSecondary
                                      ? AppColors.white
                                      : AppColors.textPrimary),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.icon != null) ...[
                                AnimatedBuilder(
                                  animation: _hoverController,
                                  builder: (context, child) {
                                    return Transform.translate(
                                      offset: Offset(_isHovered ? 4 : 0, 0),
                                      child: Transform.scale(
                                        scale: _isHovered ? 1.1 : 1.0,
                                        child: Icon(widget.icon, size: 20),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 12),
                              ],
                              if (widget.isLoading)
                                const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.white,
                                    ),
                                  ),
                                )
                              else
                                AnimatedBuilder(
                                  animation: _hoverController,
                                  builder: (context, child) {
                                    return Transform.translate(
                                      offset: Offset(_isHovered ? 8 : 0, 0),
                                      child: Text(widget.text),
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildParticles() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return Stack(
          children: [
            _buildParticle(0.18, 0.08, 0.0),
            _buildParticle(0.38, 0.12, 0.5),
            _buildParticle(0.62, 0.10, 1.0),
            _buildParticle(0.78, 0.06, 1.5),
          ],
        );
      },
    );
  }

  Widget _buildParticle(double left, double bottom, double delay) {
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _particleController,
        curve: Interval(
          delay / 2.5,
          (delay + 1.0) / 2.5,
          curve: Curves.easeInOut,
        ),
      ),
    );

    return Positioned(
      left: MediaQuery.of(context).size.width * left,
      bottom: bottom * AppDimensions.liquidButtonHeight,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final progress = animation.value;
          final opacity = progress < 0.4
              ? progress / 0.4
              : progress > 0.6
              ? (1.0 - progress) / 0.4
              : 1.0;

          return Transform.translate(
            offset: Offset(0, -32 * progress),
            child: Transform.scale(
              scale: 0.95 + (0.1 * progress),
              child: Opacity(
                opacity: opacity,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

