import 'package:myskin_flutterbytes/src/features/features.dart';

mixin NotifierHelper<T> on Notifier<AppState<T>> {
  void notifyOnError({
    AppState<T>? state_,
    nullifyError = false,
    Failure? error,
    T? data,
  }) {
    state = (state_ ?? state).copyWith(
      status: StateStatus.failure,
      data: data,
      failure: nullifyError ? null : error,
    );
    AppLogger.logError(state.toString(), tag: "state after notify Error");
  }

  void notifyOnLoading({
    nullifyError = true,
    AppState<T>? state_,
  }) {
    if (state.status == StateStatus.loading) return;

    state = (state_ ?? state).copyWith(
      status: StateStatus.loading,
      data: null,
      failure: nullifyError ? null : (state_ ?? state).failure,
    );
    AppLogger.log(state.toString(), tag: "state after notify Loading");
  }

  void notifyOnSuccess({
    T? data,
    AppState<T>? state_,
    nullifyError = true,
  }) {
    state = AppState(
      status: StateStatus.success,
      data: data,
      failure: nullifyError ? null : (state_ ?? state).failure,
    );
    AppLogger.logSuccess(state.toString(), tag: "state after notify Success");
  }

  void notifyIdle({
    T? data,
    AppState<T>? state_,
    nullifyError = true,
  }) {
    state = state.copyWith(
      status: StateStatus.idle,
      data: data,
      failure: nullifyError ? null : (state_ ?? state).failure,
    );
    AppLogger.logWarning(state.toString(), tag: "state after notify Idle");
  }
}
