import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

// String Extensions
extension StringExtensions on String {
  /// Capitalize first letter of string
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Capitalize first letter of each word
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Check if string is a valid email
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  /// Check if string is a valid phone number
  bool get isValidPhone {
    return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(this);
  }

  /// Check if string is a valid URL
  bool get isValidUrl {
    return RegExp(
      r'^https?:\/\/[\w\-]+(\.[\w\-]+)+([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?$',
    ).hasMatch(this);
  }

  /// Remove all whitespace from string
  String get removeWhitespace {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Truncate string to specified length
  String truncate(int length, {String suffix = '...'}) {
    if (this.length <= length) return this;
    return '${substring(0, length)}$suffix';
  }

  /// Format string as currency
  String toCurrency({String symbol = 'KES'}) {
    if (isEmpty) return '$symbol 0';
    final number = double.tryParse(this) ?? 0;
    return '$symbol ${NumberFormat('#,##0.00').format(number)}';
  }

  /// Format string as number
  String toNumber() {
    if (isEmpty) return '0';
    final number = double.tryParse(this) ?? 0;
    return NumberFormat('#,##0').format(number);
  }

  /// Convert string to slug
  String get toSlug {
    return toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .trim();
  }

  /// Check if string contains only digits
  bool get isNumeric {
    return RegExp(r'^\d+$').hasMatch(this);
  }

  /// Check if string is null or empty
  bool get isNullOrEmpty {
    return isEmpty;
  }

  /// Check if string is not null and not empty
  bool get isNotNullOrEmpty {
    return isNotEmpty;
  }
}

// DateTime Extensions
extension DateTimeExtensions on DateTime {
  /// Format date as string
  String toFormattedString({String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(this);
  }

  /// Format date for display
  String get toDisplayString {
    return DateFormat('MMM dd, yyyy').format(this);
  }

  /// Format date and time for display
  String get toDisplayDateTimeString {
    return DateFormat('MMM dd, yyyy HH:mm').format(this);
  }

  /// Get relative time string (e.g., "2 hours ago")
  String get toRelativeString {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }

  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if date is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Get start of day
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  /// Get end of day
  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  /// Get start of week
  DateTime get startOfWeek {
    final weekday = this.weekday;
    return subtract(Duration(days: weekday - 1)).startOfDay;
  }

  /// Get end of week
  DateTime get endOfWeek {
    final weekday = this.weekday;
    return add(Duration(days: 7 - weekday)).endOfDay;
  }

  /// Get start of month
  DateTime get startOfMonth {
    return DateTime(year, month, 1);
  }

  /// Get end of month
  DateTime get endOfMonth {
    return DateTime(year, month + 1, 0, 23, 59, 59, 999);
  }

  /// Add days to date
  DateTime addDays(int days) {
    return add(Duration(days: days));
  }

  /// Subtract days from date
  DateTime subtractDays(int days) {
    return subtract(Duration(days: days));
  }
}

// BuildContext Extensions
extension BuildContextExtensions on BuildContext {
  /// Get screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Get safe area padding
  EdgeInsets get safeAreaPadding => MediaQuery.of(this).padding;

  /// Get status bar height
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  /// Get bottom navigation bar height
  double get bottomNavigationBarHeight => MediaQuery.of(this).padding.bottom;

  /// Check if device is tablet
  bool get isTablet {
    final size = screenSize;
    return size.width >= 768 && size.width < 1024;
  }

  /// Check if device is desktop
  bool get isDesktop {
    final size = screenSize;
    return size.width >= 1024;
  }

  /// Check if device is mobile
  bool get isMobile {
    return !isTablet && !isDesktop;
  }

  /// Get theme
  ThemeData get theme => Theme.of(this);

  /// Get text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Get primary color
  Color get primaryColor => Theme.of(this).primaryColor;

  /// Show snackbar
  void showSnackBar(
    String message, {
    Color? backgroundColor,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  /// Show error snackbar
  void showErrorSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.red);
  }

  /// Show success snackbar
  void showSuccessSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.green);
  }

  /// Show info snackbar
  void showInfoSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.blue);
  }

  /// Navigate to page
  Future<T?> navigateTo<T>(Widget page) {
    return Navigator.of(
      this,
    ).push<T>(MaterialPageRoute(builder: (context) => page));
  }

  /// Navigate and replace current page
  Future<T?> navigateAndReplace<T>(Widget page) {
    return Navigator.of(this).pushReplacement<T, dynamic>(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// Navigate and clear stack
  Future<T?> navigateAndClearStack<T>(Widget page) {
    return Navigator.of(this).pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }

  /// Go back
  void goBack<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// Check if can go back
  bool get canGoBack => Navigator.of(this).canPop();

  /// Show loading dialog
  void showLoadingDialog({String? message}) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            if (message != null) ...[
              const SizedBox(width: 16),
              Expanded(child: Text(message)),
            ],
          ],
        ),
      ),
    );
  }

  /// Hide loading dialog
  void hideLoadingDialog() {
    Navigator.of(this).pop();
  }

  /// Show confirmation dialog
  Future<bool?> showConfirmationDialog({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) {
    return showDialog<bool>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }
}

// List Extensions
extension ListExtensions<T> on List<T> {
  /// Get first element or null
  T? get firstOrNull => isEmpty ? null : first;

  /// Get last element or null
  T? get lastOrNull => isEmpty ? null : last;

  /// Get element at index or null
  T? elementAtOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// Check if list is not empty
  bool get isNotEmpty => !isEmpty;

  /// Add element if not null
  void addIfNotNull(T? element) {
    if (element != null) add(element);
  }

  /// Add all elements if not null
  void addAllIfNotNull(Iterable<T>? elements) {
    if (elements != null) addAll(elements);
  }

  /// Remove duplicates
  List<T> get unique => toSet().toList();

  /// Chunk list into smaller lists
  List<List<T>> chunk(int size) {
    final chunks = <List<T>>[];
    for (int i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }

  /// Get random element
  T? get random {
    if (isEmpty) return null;
    final random = DateTime.now().millisecondsSinceEpoch % length;
    return this[random];
  }

  /// Shuffle list
  List<T> get shuffled {
    final list = List<T>.from(this);
    list.shuffle();
    return list;
  }
}

// Map Extensions
extension MapExtensions<K, V> on Map<K, V> {
  /// Get value or default
  V getOrDefault(K key, V defaultValue) {
    return containsKey(key) ? this[key]! : defaultValue;
  }

  /// Get value or null
  V? getOrNull(K key) {
    return containsKey(key) ? this[key] : null;
  }

  /// Check if map is not empty
  bool get isNotEmpty => !isEmpty;

  /// Remove null values
  Map<K, V> get withoutNulls {
    return Map.fromEntries(entries.where((entry) => entry.value != null));
  }
}

// Double Extensions
extension DoubleExtensions on double {
  /// Format as currency
  String toCurrency({String symbol = 'KES'}) {
    return '$symbol ${NumberFormat('#,##0.00').format(this)}';
  }

  /// Format as number
  String toNumber() {
    return NumberFormat('#,##0').format(this);
  }

  /// Format as percentage
  String toPercentage({int decimals = 1}) {
    return '${NumberFormat('#,##0.${'0' * decimals}').format(this)}%';
  }

  /// Round to specified decimal places
  double roundTo(int decimals) {
    final factor = math.pow(10, decimals);
    return (this * factor).round() / factor;
  }

  /// Check if number is positive
  bool get isPositive => this > 0;

  /// Check if number is negative
  bool get isNegative => this < 0;

  /// Check if number is zero
  bool get isZero => this == 0;

  /// Check if number is even
  bool get isEven => this % 2 == 0;

  /// Check if number is odd
  bool get isOdd => this % 2 != 0;
}

// Int Extensions
extension IntExtensions on int {
  /// Format as currency
  String toCurrency({String symbol = 'KES'}) {
    return '$symbol ${NumberFormat('#,##0').format(this)}';
  }

  /// Format as number
  String toNumber() {
    return NumberFormat('#,##0').format(this);
  }

  /// Check if number is positive
  bool get isPositive => this > 0;

  /// Check if number is negative
  bool get isNegative => this < 0;

  /// Check if number is zero
  bool get isZero => this == 0;

  /// Check if number is even
  bool get isEven => this % 2 == 0;

  /// Check if number is odd
  bool get isOdd => this % 2 != 0;

  /// Get ordinal string (1st, 2nd, 3rd, etc.)
  String get ordinal {
    if (this >= 11 && this <= 13) {
      return '${this}th';
    }
    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }
}

// Widget Extensions
extension WidgetExtensions on Widget {
  /// Add padding to widget
  Widget padding(EdgeInsets padding) {
    return Padding(padding: padding, child: this);
  }

  /// Add margin to widget
  Widget margin(EdgeInsets margin) {
    return Container(margin: margin, child: this);
  }

  /// Add border to widget
  Widget border(Border border) {
    return Container(
      decoration: BoxDecoration(border: border),
      child: this,
    );
  }

  /// Add background color to widget
  Widget backgroundColor(Color color) {
    return Container(color: color, child: this);
  }

  /// Add corner radius to widget
  Widget cornerRadius(double radius) {
    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);
  }

  /// Add shadow to widget
  Widget shadow(List<BoxShadow> shadows) {
    return Container(
      decoration: BoxDecoration(boxShadow: shadows),
      child: this,
    );
  }

  /// Center widget
  Widget get center {
    return Center(child: this);
  }

  /// Align widget
  Widget align(Alignment alignment) {
    return Align(alignment: alignment, child: this);
  }

  /// Make widget expandable
  Widget get expanded {
    return Expanded(child: this);
  }

  /// Make widget flexible
  Widget flexible({int flex = 1}) {
    return Flexible(flex: flex, child: this);
  }

  /// Add gesture detector
  Widget onTap(VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: this);
  }

  /// Add inkwell
  Widget inkWell({VoidCallback? onTap, BorderRadius? borderRadius}) {
    return InkWell(onTap: onTap, borderRadius: borderRadius, child: this);
  }
}
