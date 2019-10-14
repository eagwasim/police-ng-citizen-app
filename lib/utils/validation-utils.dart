class ValidationUtils {
  static RegExp _phoneNumberRegx = new RegExp(
    "[0]?[7-9][0-9]{9}",
    caseSensitive: false,
    multiLine: false,
  );

  static bool isValidPhoneNumber(String phoneNumber) {
    return _phoneNumberRegx.hasMatch(phoneNumber);
  }
}
