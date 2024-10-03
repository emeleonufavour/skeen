import 'package:myskin_flutterbytes/src/features/features.dart';

final googleAuthProvider =
    NotifierProvider<GoogleAuthNotifier, AppState<AuthResultEntity>>(
  GoogleAuthNotifier.new,
);

class GoogleAuthNotifier extends Notifier<AppState<AuthResultEntity>>
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
