import 'package:myskin_flutterbytes/src/features/features.dart';

final signInProvider =
    NotifierProvider<SignInNotifier, AppState<AuthResultEntity>>(
  SignInNotifier.new,
);

class SignInNotifier extends Notifier<AppState<AuthResultEntity>>
    with NotifierHelper<AuthResultEntity> {
  late final AuthRepository _authRepository;
  late final SessionManager _sessionManager;

  @override
  AppState<AuthResultEntity> build() {
    _authRepository = ref.read(authRepositoryProvider);
    _sessionManager = ref.read(sessionManagerProvider);

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
        _sessionManager.storeBool(isLoggedInKey, true);
        notifyOnSuccess(data: r, state_: state);
      },
    );
  }
}
