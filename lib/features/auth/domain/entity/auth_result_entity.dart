import 'package:skeen/features/features.dart';

class AuthResultEntity {
  final bool success;
  final String message;
  final UserEntity? user;

  const AuthResultEntity({
    required this.success,
    required this.message,
    this.user,
  });
}
