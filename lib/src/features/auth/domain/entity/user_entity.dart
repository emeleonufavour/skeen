class UserEntity {
  final String? email;
  final String? countryCode;
  final String? userId;
  final String? fullName;
  final String? phoneNumber;

  const UserEntity({
    this.email,
    this.phoneNumber,
    this.fullName,
    this.countryCode,
    this.userId,
  });
}
