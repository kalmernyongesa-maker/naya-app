import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_dimensions.dart';

class ElevateCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String category;
  final double price;
  final double? oldPrice;
  final double rating;
  final int reviewCount;
  final String? badge;
  final bool isNew;
  final bool isOnSale;
  final VoidCallback? onTap;
  final VoidCallback? onWishlistTap;
  final VoidCallback? onAddToCart;
  final bool isWishlisted;
  final bool isLoading;

  const ElevateCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.price,
    this.oldPrice,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.badge,
    this.isNew = false,
    this.isOnSale = false,
    this.onTap,
    this.onWishlistTap,
    this.onAddToCart,
    this.isWishlisted = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  State<ElevateCard> createState() => _ElevateCardState();
}

class _ElevateCardState extends State<ElevateCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<double> _translateAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    _scaleAnimation =
        Tween<double>(
          begin: 1.0,
          end: AppDimensions.elevateCardHoverScale,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _elevationAnimation =
        Tween<double>(
          begin: AppDimensions.elevateCardElevation,
          end: AppDimensions.elevateCardHoverElevation,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _translateAnimation =
        Tween<double>(
          begin: 0.0,
          end: AppDimensions.elevateCardHoverTranslate,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _translateAnimation.value),
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowLight.withOpacity(0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: AppColors.shadowMedium.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 1.5),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: widget.onTap,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusXL,
                        ),
                        border: Border.all(
                          color: AppColors.borderLight,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [_buildImageSection(), _buildInfoSection()],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        Container(
          height: AppDimensions.productImageHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppDimensions.radiusXL),
              topRight: Radius.circular(AppDimensions.radiusXL),
            ),
            color: AppColors.gray100,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppDimensions.radiusXL),
              topRight: Radius.circular(AppDimensions.radiusXL),
            ),
            child: widget.isLoading
                ? Container(
                    color: AppColors.gray100,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryPink,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppColors.gray100,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryPink,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.gray100,
                      child: const Icon(
                        Icons.image_not_supported,
                        color: AppColors.gray400,
                        size: 48,
                      ),
                    ),
                  ),
          ),
        ),
        _buildBadge(),
        _buildWishlistButton(),
      ],
    );
  }

  Widget _buildBadge() {
    if (!widget.isNew && !widget.isOnSale && widget.badge == null) {
      return const SizedBox.shrink();
    }

    String badgeText;
    Color badgeColor;

    if (widget.isNew) {
      badgeText = 'NEW';
      badgeColor = AppColors.badgeNew;
    } else if (widget.isOnSale) {
      badgeText = 'SALE';
      badgeColor = AppColors.badgeDiscount;
    } else {
      badgeText = widget.badge ?? '';
      badgeColor = AppColors.badgeSale;
    }

    return Positioned(
      top: AppDimensions.spacingM,
      left: AppDimensions.spacingM,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingM,
          vertical: AppDimensions.spacingXS,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [badgeColor, AppColors.primaryPink],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(badgeText, style: AppTextStyles.badgeText),
      ),
    );
  }

  Widget _buildWishlistButton() {
    return Positioned(
      top: AppDimensions.spacingM,
      right: AppDimensions.spacingM,
      child: AnimatedOpacity(
        opacity: _isHovered ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.85),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onWishlistTap,
              borderRadius: BorderRadius.circular(19),
              child: Icon(
                widget.isWishlisted ? Icons.favorite : Icons.favorite_border,
                color: AppColors.primaryPink,
                size: AppDimensions.iconM,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacingL),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.22),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(AppDimensions.radiusXL),
          bottomRight: Radius.circular(AppDimensions.radiusXL),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.category.toUpperCase(),
            style: AppTextStyles.categoryText,
          ),
          const SizedBox(height: AppDimensions.spacingXS),
          Text(
            widget.title,
            style: AppTextStyles.productTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppDimensions.spacingS),
          _buildPriceSection(),
          const SizedBox(height: AppDimensions.spacingS),
          _buildRatingSection(),
          const SizedBox(height: AppDimensions.spacingM),
          _buildAddToCartButton(),
        ],
      ),
    );
  }

  Widget _buildPriceSection() {
    return Row(
      children: [
        Text(
          'KES ${widget.price.toStringAsFixed(0)}',
          style: AppTextStyles.priceText,
        ),
        if (widget.oldPrice != null) ...[
          const SizedBox(width: AppDimensions.spacingS),
          Text(
            'KES ${widget.oldPrice!.toStringAsFixed(0)}',
            style: AppTextStyles.oldPriceText,
          ),
        ],
      ],
    );
  }

  Widget _buildRatingSection() {
    if (widget.rating == 0.0) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        ...List.generate(5, (index) {
          if (index < widget.rating.floor()) {
            return const Icon(
              Icons.star,
              color: AppColors.ratingStar,
              size: AppDimensions.starSize,
            );
          } else if (index < widget.rating) {
            return const Icon(
              Icons.star_half,
              color: AppColors.ratingStar,
              size: AppDimensions.starSize,
            );
          } else {
            return const Icon(
              Icons.star_border,
              color: AppColors.ratingEmpty,
              size: AppDimensions.starSize,
            );
          }
        }),
        const SizedBox(width: AppDimensions.spacingXS),
        Text('(${widget.reviewCount})', style: AppTextStyles.ratingText),
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return AnimatedOpacity(
      opacity: _isHovered ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 350),
      child: Container(
        width: double.infinity,
        height: AppDimensions.buttonHeightL,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onAddToCart,
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
            child: Center(
              child: Text('Add to Cart', style: AppTextStyles.buttonText),
            ),
          ),
        ),
      ),
    );
  }
}

