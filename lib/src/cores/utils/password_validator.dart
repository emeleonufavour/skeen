class PasswordValidator {
  static bool hasAtLeast8Characters(String password) {
    final int lengthOfPassword = password.length;
    return lengthOfPassword > 8;
  }

  static bool hasASpecialCharacter(String password) {
    RegExp specialCharacterRegex = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
    return specialCharacterRegex.hasMatch(password);
  }

  static bool hasAtLeastANumber(String password) {
    RegExp numberRegex = RegExp(r'\d');
    return numberRegex.hasMatch(password);
  }

  static bool hasAtLeastALowerCase(String password) {
    RegExp lowerCaseRegex = RegExp(r'[a-z]');
    return lowerCaseRegex.hasMatch(password);
  }

  static bool hasAtLeastAnUpperCase(String password) {
    RegExp upperCaseRegex = RegExp(r'[A-Z]');
    return upperCaseRegex.hasMatch(password);
  }

  static bool isPasswordValid(String password) {
    if (password.isEmpty) {
      return false;
    }

    return hasAtLeast8Characters(password) &&
        hasASpecialCharacter(password) &&
        hasAtLeastANumber(password) &&
        hasAtLeastALowerCase(password) &&
        hasAtLeastAnUpperCase(password);
  }
}
