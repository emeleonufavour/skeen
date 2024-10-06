import 'package:skeen/cores/cores.dart';

abstract class Failure {
  const Failure({
    this.message = ErrorText.somethingWentWrong,
    this.trace,
  });

  final String message;
  final StackTrace? trace;
}
