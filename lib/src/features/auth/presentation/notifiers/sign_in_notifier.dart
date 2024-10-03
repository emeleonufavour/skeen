import 'package:myskin_flutterbytes/src/cores/utils/notifier_helper.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

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
        notifyOnError(error: l, state_: state);
      },
      (r) {
        notifyOnSuccess(data: r, state_: state);
      },
    );
  }
}
