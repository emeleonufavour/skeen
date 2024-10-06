import 'package:skeen/features/features.dart';

class AuthResultModel extends AuthResultEntity {
  const AuthResultModel({
    required super.success,
    required super.message,
    super.user,
  });
}
