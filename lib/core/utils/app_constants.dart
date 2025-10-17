class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://your-laravel-backend.com/api';
  static const String apiVersion = 'v1';
  static const Duration apiTimeout = Duration(seconds: 30);

  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String cartDataKey = 'cart_data';
  static const String wishlistDataKey = 'wishlist_data';
  static const String recentSearchesKey = 'recent_searches';
  static const String themeModeKey = 'theme_mode';
  static const String languageKey = 'language';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Image Configuration
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'webp'];
  static const String defaultImageUrl = 'https://via.placeholder.com/400x400';

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  static const int maxDescriptionLength = 1000;

  // Currency
  static const String defaultCurrency = 'KES';
  static const String currencySymbol = 'KES';

  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayDateTimeFormat = 'MMM dd, yyyy HH:mm';

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Debounce Durations
  static const Duration searchDebounce = Duration(milliseconds: 300);
  static const Duration buttonDebounce = Duration(milliseconds: 500);

  // Cache Durations
  static const Duration shortCache = Duration(minutes: 5);
  static const Duration mediumCache = Duration(hours: 1);
  static const Duration longCache = Duration(days: 1);

  // Error Messages
  static const String networkErrorMessage =
      'Please check your internet connection';
  static const String serverErrorMessage =
      'Something went wrong. Please try again';
  static const String timeoutErrorMessage =
      'Request timed out. Please try again';
  static const String unknownErrorMessage = 'An unknown error occurred';

  // Success Messages
  static const String loginSuccessMessage = 'Login successful';
  static const String registerSuccessMessage = 'Registration successful';
  static const String profileUpdateSuccessMessage =
      'Profile updated successfully';
  static const String passwordChangeSuccessMessage =
      'Password changed successfully';
  static const String orderPlacedSuccessMessage = 'Order placed successfully';
  static const String itemAddedToCartMessage = 'Item added to cart';
  static const String itemAddedToWishlistMessage = 'Item added to wishlist';
  static const String itemRemovedFromWishlistMessage =
      'Item removed from wishlist';

  // Validation Messages
  static const String requiredFieldMessage = 'This field is required';
  static const String invalidEmailMessage =
      'Please enter a valid email address';
  static const String invalidPhoneMessage = 'Please enter a valid phone number';
  static const String passwordTooShortMessage =
      'Password must be at least 8 characters';
  static const String passwordMismatchMessage = 'Passwords do not match';
  static const String invalidNameMessage = 'Please enter a valid name';

  // App Information
  static const String appName = 'ManuelThrifts';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Premium Thrift Fashion';
  static const String appWebsite = 'https://manuelthrifts.com';
  static const String appEmail = 'support@manuelthrifts.com';
  static const String appPhone = '+254 700 000 000';

  // Social Media
  static const String facebookUrl = 'https://facebook.com/manuelthrifts';
  static const String instagramUrl = 'https://instagram.com/manuelthrifts';
  static const String twitterUrl = 'https://twitter.com/manuelthrifts';
  static const String youtubeUrl = 'https://youtube.com/manuelthrifts';
  static const String linkedinUrl =
      'https://linkedin.com/company/manuelthrifts';

  // Payment Methods
  static const String mpesaPaymentMethod = 'mpesa';
  static const String stripePaymentMethod = 'stripe';
  static const String cashOnDeliveryMethod = 'cod';

  // Order Status
  static const String orderStatusPending = 'pending';
  static const String orderStatusProcessing = 'processing';
  static const String orderStatusShipped = 'shipped';
  static const String orderStatusDelivered = 'delivered';
  static const String orderStatusCancelled = 'cancelled';
  static const String orderStatusRefunded = 'refunded';

  // Payment Status
  static const String paymentStatusPending = 'pending';
  static const String paymentStatusPaid = 'paid';
  static const String paymentStatusFailed = 'failed';
  static const String paymentStatusRefunded = 'refunded';

  // Delivery Status
  static const String deliveryStatusPending = 'pending';
  static const String deliveryStatusInTransit = 'in_transit';
  static const String deliveryStatusDelivered = 'delivered';
  static const String deliveryStatusFailed = 'failed';

  // User Roles
  static const String userRoleCustomer = 'customer';
  static const String userRoleAdmin = 'admin';
  static const String userRoleModerator = 'moderator';

  // Product Status
  static const String productStatusActive = 'active';
  static const String productStatusInactive = 'inactive';
  static const String productStatusOutOfStock = 'out_of_stock';
  static const String productStatusDiscontinued = 'discontinued';

  // Review Status
  static const String reviewStatusPending = 'pending';
  static const String reviewStatusApproved = 'approved';
  static const String reviewStatusRejected = 'rejected';

  // Notification Types
  static const String notificationTypeOrder = 'order';
  static const String notificationTypePayment = 'payment';
  static const String notificationTypeDelivery = 'delivery';
  static const String notificationTypePromotion = 'promotion';
  static const String notificationTypeReview = 'review';

  // File Upload
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedFileTypes = [
    'jpg',
    'jpeg',
    'png',
    'pdf',
    'doc',
    'docx',
  ];

  // Search Configuration
  static const int minSearchLength = 2;
  static const int maxSearchResults = 50;
  static const int maxRecentSearches = 10;

  // Cart Configuration
  static const int maxCartItems = 50;
  static const int maxQuantityPerItem = 10;

  // Wishlist Configuration
  static const int maxWishlistItems = 100;

  // Pagination Configuration
  static const int defaultPage = 1;
  static const int maxPage = 1000;

  // Cache Configuration
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB
  static const Duration defaultCacheExpiry = Duration(hours: 24);

  // Security
  static const int maxLoginAttempts = 5;
  static const Duration lockoutDuration = Duration(minutes: 15);
  static const int sessionTimeoutMinutes = 30;

  // Performance
  static const int maxConcurrentRequests = 5;
  static const Duration requestRetryDelay = Duration(seconds: 2);
  static const int maxRetryAttempts = 3;

  // Analytics
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enablePerformanceMonitoring = true;

  // Feature Flags
  static const bool enableDarkMode = true;
  static const bool enableNotifications = true;
  static const bool enableBiometricAuth = true;
  static const bool enableOfflineMode = true;
  static const bool enablePushNotifications = true;
  static const bool enableSocialLogin = true;
  static const bool enableGuestCheckout = true;
  static const bool enableWishlist = true;
  static const bool enableReviews = true;
  static const bool enableRatings = true;
  static const bool enableCoupons = true;
  static const bool enableLoyaltyProgram = true;
  static const bool enableBNPL = true;

  // Localization
  static const String defaultLanguage = 'en';
  static const List<String> supportedLanguages = ['en', 'sw'];

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // Retry Configuration
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 1);
  static const double retryBackoffMultiplier = 2.0;

  // Logging
  static const bool enableLogging = true;
  static const String logLevel = 'INFO';
  static const int maxLogFileSize = 10 * 1024 * 1024; // 10MB
  static const int maxLogFiles = 5;
}



