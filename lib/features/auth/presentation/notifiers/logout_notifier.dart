import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

final logoutNotifier =
    NotifierProvider<LogOutNotifier, AppState<AuthResultEntity>>(
  LogOutNotifier.new,
);

class LogOutNotifier extends Notifier<AppState<AuthResultEntity>>
    with NotifierHelper<AuthResultEntity> {
  late final AuthRepository _authRepository;

  @override
  AppState<AuthResultEntity> build() {
    _authRepository = ref.read(authRepositoryProvider);

    return AppState.initial();
  }

  void execute() async {
    notifyOnLoading();

    final res = await _authRepository.signInWithGoogle();

    res.fold(
      (l) {
        notifyOnError(error: l, state_: state);
      },
      (r) {
        notifyOnSuccess(data: r, state_: state);
      },
    );
  }
}
