import 'package:email_validator/email_validator.dart';

class Validate {
  static String? validEmail (String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email cannot be empty";
    }
    if (!EmailValidator.validate(value)) {
      return "Invalid email format";
    }
    return null;
  }

  static String? validPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password cannot be empty";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }
}