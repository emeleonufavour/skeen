import 'package:skeen/cores/cores.dart';

class AppState<T> {
  final StateStatus status;
  T? data;
  final Failure? failure;

  bool get isLoading => status == StateStatus.loading;
  bool get isSuccess => status == StateStatus.success;
  bool get isFailure => status == StateStatus.failure;
  bool get isIdle => status == StateStatus.idle;

  AppState({
    required this.status,
    required this.data,
    required this.failure,
  });

  factory AppState.initial({
    T? data,
  }) {
    return AppState(status: StateStatus.idle, data: data, failure: null);
  }

  AppState<T> copyWith({
    StateStatus? status,
    T? data,
    Failure? failure,
  }) {
    return AppState<T>(
        status: status ?? this.status,
        data: data ?? this.data,
        failure: failure ?? this.failure);
  }

  @override
  String toString() =>
      'AppState(status: $status, data: ${data.toString()}, failure: $failure)';
}

enum StateStatus {
  loading,
  success,
  failure,
  idle;
}
