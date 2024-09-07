
import 'package:myskin_flutterbytes/src/cores/cores.dart';

class BaseFailures extends Failure {
  const BaseFailures({
    required super.message,
    super.trace,
  });
  @override
  String toString() {
    return 'Base Failures: $message $trace';
  }
}

class SocketFailures extends Failure {
  const SocketFailures({
    required super.message,
    super.trace,
  });
}
