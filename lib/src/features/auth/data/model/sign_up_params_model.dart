class SignUpParamsModel {
  final String fullName;
  final String password;
  final String email;
  final String phoneNumber;
  final String countryCode;

  SignUpParamsModel({
    required this.phoneNumber,
    required this.fullName,
    required this.password,
    required this.email,
    required this.countryCode,
  });
}
