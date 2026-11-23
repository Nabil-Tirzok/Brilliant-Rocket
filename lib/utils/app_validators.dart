class AppValidators {
  AppValidators._();

  static String? required(String? value, {String message = 'This field is required'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? email(String? value) {
    final requiredError = required(
      value,
      message: 'Please enter your email',
    );
    if (requiredError != null) {
      return requiredError;
    }

    final emailRegex = RegExp(r'^[\w.-]+@([\w-]+\.)+[\w-]{2,}$');
    if (!emailRegex.hasMatch(value!.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? passwordsMatch(String? password, String? confirmation) {
    if (password != confirmation) {
      return 'Passwords do not match.';
    }
    return null;
  }
}
