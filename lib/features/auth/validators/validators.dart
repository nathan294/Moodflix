String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email';
  }
  if (!value.contains('@')) {
    return 'Please enter a valid email';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }
  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one digit';
  }
  if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]+'))) {
    return 'Password must contain at least one special character';
  }
  return null;
}

String? validateConfirmPassword(String? value, String? password) {
  if (value != password) {
    return 'Passwords do not match';
  }
  return null;
}
