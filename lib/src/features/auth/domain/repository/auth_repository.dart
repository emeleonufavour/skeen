import 'package:fpdart/fpdart.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepoImpl(
    authDataSource: ref.read(authRemoteDataSourceProvider),
  ),
);

abstract class AuthRepository {
  Future<Either<Failure, AuthResultEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthResultEntity>> register(
    SignUpParamsModel signUpParams,
  );

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, void>> forgotPassword(String email);

  Future<Either<Failure, AuthResultEntity>> signInWithGoogle();
}
