class AppValidators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (value.length > 128) {
      return 'Password must be less than 128 characters';
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for at least one digit
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    // Check for at least one special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  // Confirm password validation
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  // Name validation
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }

    if (value.length > 50) {
      return 'Name must be less than 50 characters';
    }

    // Check for valid characters (letters, spaces, hyphens, apostrophes)
    if (!RegExp(r"^[a-zA-Z\s\-']+$").hasMatch(value)) {
      return 'Name can only contain letters, spaces, hyphens, and apostrophes';
    }

    return null;
  }

  // Phone number validation
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Remove all non-digit characters
    final cleanPhone = value.replaceAll(RegExp(r'[^\d]'), '');

    // Check if it's a valid phone number (7-15 digits)
    if (cleanPhone.length < 7 || cleanPhone.length > 15) {
      return 'Please enter a valid phone number';
    }

    // Check for Kenyan phone number format
    if (cleanPhone.startsWith('254') && cleanPhone.length == 12) {
      return null; // Valid Kenyan number
    }

    if (cleanPhone.startsWith('0') && cleanPhone.length == 10) {
      return null; // Valid Kenyan number with leading 0
    }

    if (cleanPhone.startsWith('7') && cleanPhone.length == 9) {
      return null; // Valid Kenyan number without country code
    }

    return 'Please enter a valid Kenyan phone number';
  }

  // Required field validation
  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  // Minimum length validation
  static String? validateMinLength(
    String? value,
    int minLength, {
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    if (value.length < minLength) {
      return '${fieldName ?? 'This field'} must be at least $minLength characters long';
    }

    return null;
  }

  // Maximum length validation
  static String? validateMaxLength(
    String? value,
    int maxLength, {
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    if (value.length > maxLength) {
      return '${fieldName ?? 'This field'} must be less than $maxLength characters';
    }

    return null;
  }

  // URL validation
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL is required';
    }

    final urlRegex = RegExp(
      r'^https?:\/\/[\w\-]+(\.[\w\-]+)+([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?$',
    );

    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  // Numeric validation
  static String? validateNumeric(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    if (double.tryParse(value) == null) {
      return '${fieldName ?? 'This field'} must be a valid number';
    }

    return null;
  }

  // Integer validation
  static String? validateInteger(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    if (int.tryParse(value) == null) {
      return '${fieldName ?? 'This field'} must be a valid integer';
    }

    return null;
  }

  // Positive number validation
  static String? validatePositiveNumber(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    final number = double.tryParse(value);
    if (number == null) {
      return '${fieldName ?? 'This field'} must be a valid number';
    }

    if (number <= 0) {
      return '${fieldName ?? 'This field'} must be greater than 0';
    }

    return null;
  }

  // Range validation
  static String? validateRange(
    String? value,
    double min,
    double max, {
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    final number = double.tryParse(value);
    if (number == null) {
      return '${fieldName ?? 'This field'} must be a valid number';
    }

    if (number < min || number > max) {
      return '${fieldName ?? 'This field'} must be between $min and $max';
    }

    return null;
  }

  // Date validation
  static String? validateDate(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    try {
      DateTime.parse(value);
      return null;
    } catch (e) {
      return '${fieldName ?? 'This field'} must be a valid date';
    }
  }

  // Future date validation
  static String? validateFutureDate(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    try {
      final date = DateTime.parse(value);
      if (date.isBefore(DateTime.now())) {
        return '${fieldName ?? 'This field'} must be a future date';
      }
      return null;
    } catch (e) {
      return '${fieldName ?? 'This field'} must be a valid date';
    }
  }

  // Past date validation
  static String? validatePastDate(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    try {
      final date = DateTime.parse(value);
      if (date.isAfter(DateTime.now())) {
        return '${fieldName ?? 'This field'} must be a past date';
      }
      return null;
    } catch (e) {
      return '${fieldName ?? 'This field'} must be a valid date';
    }
  }

  // Credit card number validation
  static String? validateCreditCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'Credit card number is required';
    }

    // Remove spaces and dashes
    final cleanNumber = value.replaceAll(RegExp(r'[\s\-]'), '');

    // Check if it's all digits
    if (!RegExp(r'^\d+$').hasMatch(cleanNumber)) {
      return 'Credit card number must contain only digits';
    }

    // Check length (13-19 digits)
    if (cleanNumber.length < 13 || cleanNumber.length > 19) {
      return 'Credit card number must be between 13 and 19 digits';
    }

    // Luhn algorithm validation
    if (!_isValidLuhn(cleanNumber)) {
      return 'Invalid credit card number';
    }

    return null;
  }

  // CVV validation
  static String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'CVV is required';
    }

    if (!RegExp(r'^\d{3,4}$').hasMatch(value)) {
      return 'CVV must be 3 or 4 digits';
    }

    return null;
  }

  // Expiry date validation
  static String? validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Expiry date is required';
    }

    // Check format MM/YY
    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
      return 'Expiry date must be in MM/YY format';
    }

    final parts = value.split('/');
    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || year == null) {
      return 'Invalid expiry date format';
    }

    if (month < 1 || month > 12) {
      return 'Month must be between 01 and 12';
    }

    // Check if card is expired
    final now = DateTime.now();
    final currentYear = now.year % 100;
    final currentMonth = now.month;

    if (year < currentYear || (year == currentYear && month < currentMonth)) {
      return 'Credit card has expired';
    }

    return null;
  }

  // Kenyan ID validation
  static String? validateKenyanId(String? value) {
    if (value == null || value.isEmpty) {
      return 'ID number is required';
    }

    // Remove spaces
    final cleanId = value.replaceAll(' ', '');

    // Check format (8 digits)
    if (!RegExp(r'^\d{8}$').hasMatch(cleanId)) {
      return 'ID number must be 8 digits';
    }

    return null;
  }

  // KRA PIN validation
  static String? validateKraPin(String? value) {
    if (value == null || value.isEmpty) {
      return 'KRA PIN is required';
    }

    // Remove spaces and convert to uppercase
    final cleanPin = value.replaceAll(' ', '').toUpperCase();

    // Check format (A123456789A)
    if (!RegExp(r'^[A-Z]\d{9}[A-Z]$').hasMatch(cleanPin)) {
      return 'KRA PIN must be in format A123456789A';
    }

    return null;
  }

  // M-Pesa number validation
  static String? validateMpesaNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'M-Pesa number is required';
    }

    // Remove all non-digit characters
    final cleanNumber = value.replaceAll(RegExp(r'[^\d]'), '');

    // Check if it's a valid M-Pesa number
    if (cleanNumber.startsWith('254') && cleanNumber.length == 12) {
      return null; // Valid with country code
    }

    if (cleanNumber.startsWith('0') && cleanNumber.length == 10) {
      return null; // Valid with leading 0
    }

    if (cleanNumber.startsWith('7') && cleanNumber.length == 9) {
      return null; // Valid without country code
    }

    return 'Please enter a valid M-Pesa number';
  }

  // Helper method for Luhn algorithm
  static bool _isValidLuhn(String number) {
    int sum = 0;
    bool alternate = false;

    // Process digits from right to left
    for (int i = number.length - 1; i >= 0; i--) {
      int digit = int.parse(number[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit = (digit % 10) + 1;
        }
      }

      sum += digit;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }

  // Custom validation
  static String? validateCustom(
    String? value,
    bool Function(String) validator,
    String errorMessage,
  ) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }

    if (!validator(value)) {
      return errorMessage;
    }

    return null;
  }

  // Multiple validations
  static String? validateMultiple(
    String? value,
    List<String? Function(String?)> validators,
  ) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}



