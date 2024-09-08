import 'dart:async';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';

Future<Either<Failure, T>> callAction<T>(Future<T> Function() action) async {
  try {
    final result = await action();
    return Right(result);
  } on SocketException {
    return const Left(SocketFailures(message: ErrorText.noInternet));
  } on TimeoutException {
    return const Left(BaseFailures(message: ErrorText.timeOutError));
  } catch (e, s) {
    AppLogger.logError(
      tag: 'BaseRepoImpl Call Action',
      'Exception: $e, StackTrace: $s',
    );

    if (e is BaseFailures) {
      return Left(
        BaseFailures(message: e.message, trace: s),
      );
    }

    return Left(
      BaseFailures(
        message: e.toString(),
        trace: s,
      ),
    );
  }
}

Stream<Either<Failure, T>> callStreamAction<T>(
  Stream<T> Function() action,
) async* {
  try {
    final stream = action();

    await for (final result in stream) {
      yield Right(result);
    }
  } on SocketException {
    yield const Left(SocketFailures(message: ErrorText.noInternet));
  } on TimeoutException {
    yield const Left(BaseFailures(message: ErrorText.timeOutError));
  } catch (e, s) {
    AppLogger.logError(
      tag: 'BaseRepoImpl CallStreamAction',
      'Exception: $e, StackTrace: $s',
    );
    if (e is BaseFailures) {
      yield Left(BaseFailures(message: e.message));
    } else {
      yield Left(BaseFailures(message: e.toString()));
    }
  }
}
