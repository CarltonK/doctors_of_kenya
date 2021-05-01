class ValidationHelper {
  ValidationHelper.empty();

  String validateNames(String value) {
    if (value.isEmpty) {
      return 'Please provide a name';
    }
    return null;
  }

  String validateEmailAddress(String value) {
    if (value.isEmpty) {
      return 'Please provide an email address';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please provide a password';
    }
    if (value.length < 6) {
      return 'Your password is too short';
    }
    return null;
  }
}
