import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

mixin RepositoryErrorHandler {
  FutureOr<Either<Failure, T>> callAction<T>(
    Future<T> Function() action,
  ) async {
    try {
      final result = await action();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Either.left(CustomFirebaseException(e.code));
    } on FirebaseException catch (e, s) {
      AppLogger.log('Error From Firebase: $e : Stack Trace $s');
      return Either.left(CustomFirebaseException(e.code));
    } on SocketException {
      return const Left(SocketFailures(message: ErrorText.noInternet));
    } on TimeoutException {
      return const Left(BaseFailures(message: ErrorText.timeOutError));
    } catch (e, s) {
      AppLogger.log('$e $s', tag: 'CATCH CALL ACTION');
      if (e is BaseFailures) {
        return Left(BaseFailures(message: e.message));
      }

      return Left(BaseFailures(message: e.toString()));
    }
  }
}
