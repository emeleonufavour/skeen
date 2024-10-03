import 'package:myskin_flutterbytes/src/features/features.dart';

final signUpProvider =
    NotifierProvider<SignUpNotifier, AppState<AuthResultEntity>>(
  SignUpNotifier.new,
);

class SignUpNotifier extends Notifier<AppState<AuthResultEntity>>
    with NotifierHelper<AuthResultEntity> {
  late final AuthRepository _authRepository;

  @override
  AppState<AuthResultEntity> build() {
    _authRepository = ref.read(authRepositoryProvider);

    return AppState.initial();
  }

  void signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    notifyOnLoading();
    final res = await _authRepository.register(
      SignUpParamsModel(
        email: email,
        fullName: fullName,
        password: password,
      ),
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
