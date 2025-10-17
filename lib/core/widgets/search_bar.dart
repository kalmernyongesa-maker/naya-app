import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_dimensions.dart';

class CustomSearchBar extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final bool enabled;
  final bool autofocus;
  final TextEditingController? controller;
  final List<SearchSuggestion>? suggestions;
  final ValueChanged<SearchSuggestion>? onSuggestionTap;
  final bool showSuggestions;

  const CustomSearchBar({
    Key? key,
    this.hintText = 'Search products, brands, categories...',
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.enabled = true,
    this.autofocus = false,
    this.controller,
    this.suggestions,
    this.onSuggestionTap,
    this.showSuggestions = true,
  }) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<CustomSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _elevationAnimation = Tween<double>(begin: 2.0, end: 8.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });

    if (_isFocused) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _onSuggestionTap(SearchSuggestion suggestion) {
    widget.onSuggestionTap?.call(suggestion);
    _focusNode.unfocus();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (widget.suggestions == null || widget.suggestions!.isEmpty) return;

      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowDown:
          setState(() {
            _selectedIndex = (_selectedIndex + 1) % widget.suggestions!.length;
          });
          break;
        case LogicalKeyboardKey.arrowUp:
          setState(() {
            _selectedIndex = (_selectedIndex - 1 + widget.suggestions!.length) %
                widget.suggestions!.length;
          });
          break;
        case LogicalKeyboardKey.enter:
          if (_selectedIndex >= 0 &&
              _selectedIndex < widget.suggestions!.length) {
            _onSuggestionTap(widget.suggestions![_selectedIndex]);
          } else {
            widget.onSubmitted?.call(widget.controller?.text ?? '');
          }
          break;
        case LogicalKeyboardKey.escape:
          _focusNode.unfocus();
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: _handleKeyEvent,
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.searchBarRadius,
                    ),
                    border: Border.all(
                      color: _isFocused
                          ? AppColors.primaryPink
                          : AppColors.gray200,
                      width: _isFocused ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowLight.withOpacity(
                          _elevationAnimation.value / 8,
                        ),
                        blurRadius: _elevationAnimation.value * 2,
                        offset: Offset(0, _elevationAnimation.value / 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: widget.controller,
                    focusNode: _focusNode,
                    enabled: widget.enabled,
                    autofocus: widget.autofocus,
                    onChanged: widget.onChanged,
                    onSubmitted: widget.onSubmitted,
                    onTap: widget.onTap,
                    style: AppTextStyles.bodyMedium,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: AppTextStyles.searchHint,
                      prefixIcon: Icon(
                        Icons.search,
                        color: _isFocused
                            ? AppColors.primaryPink
                            : AppColors.textLight,
                        size: AppDimensions.iconL,
                      ),
                      suffixIcon: widget.controller?.text.isNotEmpty == true
                          ? IconButton(
                              icon: const Icon(
                                Icons.clear,
                                color: AppColors.textLight,
                                size: AppDimensions.iconM,
                              ),
                              onPressed: () {
                                widget.controller?.clear();
                                widget.onChanged?.call('');
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.spacingM,
                        vertical: AppDimensions.spacingM,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Suggestions Dropdown
          if (_isFocused &&
              widget.showSuggestions &&
              widget.suggestions != null &&
              widget.suggestions!.isNotEmpty)
            _buildSuggestions(),
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
    return Container(
      margin: const EdgeInsets.only(top: AppDimensions.spacingS),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(color: AppColors.gray200),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Recent Searches Header
          if (widget.suggestions!.any(
            (s) => s.type == SearchSuggestionType.recent,
          ))
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacingM,
                vertical: AppDimensions.spacingS,
              ),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.gray200)),
              ),
              child: Row(
                children: [
                  Text('Recent searches', style: AppTextStyles.labelSmall),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      // Clear recent searches
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Clear',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primaryPink,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Suggestions List
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.suggestions!.length,
              itemBuilder: (context, index) {
                final suggestion = widget.suggestions![index];
                final isSelected = index == _selectedIndex;

                return Material(
                  color: isSelected ? AppColors.gray50 : Colors.transparent,
                  child: InkWell(
                    onTap: () => _onSuggestionTap(suggestion),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.spacingM,
                        vertical: AppDimensions.spacingM,
                      ),
                      child: Row(
                        children: [
                          _buildSuggestionIcon(suggestion),
                          const SizedBox(width: AppDimensions.spacingM),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  suggestion.title,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (suggestion.subtitle != null) ...[
                                  const SizedBox(
                                    height: AppDimensions.spacingXS,
                                  ),
                                  Text(
                                    suggestion.subtitle!,
                                    style: AppTextStyles.bodySmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          if (suggestion.price != null)
                            Text(
                              'KES ${suggestion.price!.toStringAsFixed(0)}',
                              style: AppTextStyles.priceTextSmall,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionIcon(SearchSuggestion suggestion) {
    IconData iconData;
    Color iconColor;

    switch (suggestion.type) {
      case SearchSuggestionType.product:
        iconData = Icons.shopping_bag_outlined;
        iconColor = AppColors.primaryPink;
        break;
      case SearchSuggestionType.brand:
        iconData = Icons.business;
        iconColor = AppColors.secondaryPurple;
        break;
      case SearchSuggestionType.category:
        iconData = Icons.category_outlined;
        iconColor = AppColors.secondaryGreen;
        break;
      case SearchSuggestionType.color:
        iconData = Icons.palette_outlined;
        iconColor = AppColors.secondaryYellow;
        break;
      case SearchSuggestionType.material:
        iconData = Icons.texture;
        iconColor = AppColors.secondaryYellow;
        break;
      case SearchSuggestionType.recent:
        iconData = Icons.history;
        iconColor = AppColors.textLight;
        break;
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
      ),
      child: Icon(iconData, color: iconColor, size: AppDimensions.iconS),
    );
  }
}

class SearchSuggestion {
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final double? price;
  final SearchSuggestionType type;
  final String? url;
  final Map<String, dynamic>? data;

  const SearchSuggestion({
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.price,
    required this.type,
    this.url,
    this.data,
  });
}

enum SearchSuggestionType { product, brand, category, color, material, recent }
