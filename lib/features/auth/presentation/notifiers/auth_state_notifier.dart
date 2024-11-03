import 'package:skeen/cores/cores.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/features/features.dart';

final authStateNotifier = NotifierProvider<AuthStateNotifier, AppState<bool>>(
  AuthStateNotifier.new,
);

class AuthStateNotifier extends Notifier<AppState<bool>>
    with NotifierHelper<bool> {
  late final AuthRepository _authRepository;

  @override
  AppState<bool> build() {
    _authRepository = ref.read(authRepositoryProvider);

    return AppState.initial();
  }

  void execute() async {
    final res = await _authRepository.isLoggedIn();

    res.fold(
      (l) {
        notifyOnError(error: l, state_: state);
      },
      (r) {
        notifyOnSuccess(state_: state, data: r);
      },
    );
  }
}
