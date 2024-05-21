import "package:intl/intl.dart";

class Validator {
  /// Name Validator.
  static String? nameValidator(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Name'} is required';
    }

    return null;
  }

  ///Full Name
  static String? fullNameValidator(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Full Name'} is required';
    }
    final parts = value.split(" ");
    if (parts.length < 2) {
      return 'Please enter your ${fieldName ?? 'Full Name'}';
    }
    for (final part in parts) {
      if (part.length < 2) {
        return 'Each word in your ${fieldName ?? 'Full Name'} must be at least 2 characters long';
      }
      if (!RegExp(r"^[a-zA-Z]+$").hasMatch(part)) {
        return 'Please enter a valid ${fieldName ?? 'Full Name'}';
      }
    }
    return null;
  }

  /// UserName Validator.
  static String? userNameValidator(String? value, {int minLength = 3, int maxLength = 30}) {
    if (value?.isEmpty == true) {
      return "Username is required";
    }

    final usernameRegExp = RegExp(r"^[a-z][a-z\d._]{1,28}[a-z\d]$");
    if (!usernameRegExp.hasMatch(value!)) {
      if (!RegExp(r"^[a-z]").hasMatch(value)) {
        return "Username must start with a letter (a-z)";
      } else if (!RegExp(r"[a-z\d]$").hasMatch(value)) {
        return "Username must end with a letter or a number";
      } else if (!RegExp(r"^[a-z][a-z\d._]*[a-z\d]$").hasMatch(value)) {
        return "Username can only contain (a-z), (0-9), (.), (_)";
      } else if (value.length < minLength || value.length > maxLength) {
        return "The username must be between $minLength and $maxLength characters long";
      } else {
        return "Invalid username";
      }
    }

    return null;
  }

  static String? monthYearValidator(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Expiry'} is required';
    }

    // Regular expression to validate MM/YYYY format
    RegExp regex = RegExp(r"^(0[1-9]|1[0-2])/(20\d{2})$");

    if (!regex.hasMatch(value)) {
      return 'Invalid ${fieldName ?? 'Expiry'} format. Use MM/YYYY';
    }

    return null;
  }

  static String? validateCreditCard(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Card'} is required';
    }
    // Remove any non-digits from the input
    String cleanedValue = value.replaceAll(RegExp(r"[^0-9]"), "");

    if (cleanedValue.length != 16) {
      return '${fieldName ?? 'Credit Card'} must be 16 digits';
    }

    return null;
  }

  /// Validates that a value is not null or empty.
  static String? requiredValidator(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Field'} is required';
    }
    return null;
  }

  /// Validates that an email has a valid format.
  static String? emailValidator(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Email'} is Required';
    }
    if (!RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)) {
      return 'Invalid ${fieldName ?? 'email'} format';
    }
    return null;
  }

  /// Validates that a value is a valid number format.
  static String? numberValidator(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Number'} is required';
    }
    if (double.tryParse(value) == null) {
      return 'Invalid ${fieldName ?? 'number'} format';
    }
    return null;
  }

  /// Validates that a password is at least 8 characters long.
  static String? passwordValidator(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Password'} is required';
    }
    if (value.length < 8) {
      return '${fieldName ?? 'Password'} must be at least 8 characters long';
    }
    return null;
  }

  /// Validates a Strong password.
  static String? strongPasswordValidator(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Password'} is required';
    }
    final hasUppercase = value.contains(RegExp(r"[A-Z]"));
    final hasLowercase = value.contains(RegExp(r"[a-z]"));
    final hasDigits = value.contains(RegExp(r"\d"));
    final hasSpecialChars = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    if (!hasUppercase) {
      return '${fieldName ?? 'Password'} must have least one uppercase letter';
    }
    if (!hasLowercase) {
      return '${fieldName ?? 'Password'} must have least one lower letter';
    }

    if (!hasDigits) {
      return '${fieldName ?? 'Password'} must have least one digit';
    }
    if (!hasSpecialChars) {
      return '${fieldName ?? 'Password'} must have least one special character.';
    }

    if (value.length < 8) {
      return '${fieldName ?? 'Password'} must be at least 8 characters';
    }
    return null;
  }

  /// Validates that two values match (typically used for password confirmation).
  static String? confirmPasswordValidator(String? value1, String? value2, [String? fieldName]) {
    if (value1 != value2) {
      return '${fieldName ?? 'Passwords'} do not match';
    }
    return null;
  }

  /// Validates that a value is a valid URL format.
  static String? urlValidator(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'URL'} is required';
    }
    if (!Uri.parse(value).isAbsolute) {
      return 'Invalid ${fieldName ?? 'URL'} format';
    }
    return null;
  }

  /// Validates that a value contains only numeric characters.
  static String? numericValidator(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Field'} is required';
    }
    final isNumeric = double.tryParse(value) != null;
    if (!isNumeric) {
      return '${fieldName ?? 'Field'} must contain only numeric characters';
    }
    return null;
  }

  /// Validates that a value contains only alphabetic characters.
  static String? alphaValidator(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Field'} is required';
    }
    final isAlpha = RegExp(r"^[a-zA-Z]+$").hasMatch(value);
    if (!isAlpha) {
      return '${fieldName ?? 'Field'} must contain only alphabetic characters';
    }
    return null;
  }

  /// Validates that a nickname contains only alphabetic characters and/or spaces.
  static String? nicknameValidator(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Nickname'} is required';
    }

    final isAlphaWithSpaces = RegExp(r"^[a-zA-Z ]+$").hasMatch(value);
    if (!isAlphaWithSpaces) {
      return '${fieldName ?? 'Nickname'} must contain only alphabetic characters and/or spaces';
    }

    return null;
  }

  /// Validates that a value is a valid date format.
  static String? dateValidator(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Date'} is required';
    }
    try {
      DateFormat.yMd().parseStrict(value);
    } catch (_) {
      return 'Invalid ${fieldName ?? 'date'} format';
    }
    return null;
  }
}
