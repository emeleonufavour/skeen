import 'package:myskin_flutterbytes/src/cores/utils/notifier_helper.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

class SignInNotifier extends Notifier<AppState<AuthResultEntity>>
    with NotifierHelper<AuthResultEntity> {
  @override
  AppState<AuthResultEntity> build() => AppState.initial();

  void updateEmail(String value) {
    state = state.copyWith();
  }

  void updatePassword(String value) {
    state = state.copyWith();
  }

  void signIn({
    required String email,
    required String password,
  }) async {
    final res = await _authRepository.login(
      email: email,
      password: password,
    );

    res.fold(
      (l) {
        state = state.copyWith(
          status: StateStatus.failure,
          failure: l,
        );
      },
      (r) {
        state = state.copyWith(
          status: StateStatus.success,
          data: r,
        );
      },
    );
  }

  final AuthRepository _authRepository;
  SignInNotifier({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;
}
