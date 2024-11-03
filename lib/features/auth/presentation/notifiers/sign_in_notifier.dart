import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

final signInProvider =
    NotifierProvider<SignInNotifier, AppState<AuthResultEntity>>(
  SignInNotifier.new,
);

class SignInNotifier extends Notifier<AppState<AuthResultEntity>>
    with NotifierHelper<AuthResultEntity> {
  late final AuthRepository _authRepository;

  @override
  AppState<AuthResultEntity> build() {
    _authRepository = ref.read(authRepositoryProvider);

    return AppState.initial();
  }

  void signIn({
    required String email,
    required String password,
  }) async {
    notifyOnLoading();
    final res = await _authRepository.login(
      email: email,
      password: password,
    );

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
