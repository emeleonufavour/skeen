// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:skeen/cores/cores.dart';
// import 'package:skeen/features/features.dart';

// final forgotPasswordProvider =
//     NotifierProvider<ForgetPasswordNotifier, AppState<void>>(
//   ForgetPasswordNotifier.new,
// );

// class ForgetPasswordNotifier extends Notifier<AppState<void>>
//     with NotifierHelper<void> {
//   late final AuthRepository _authRepository;

//   @override
//   AppState<void> build() {
//     _authRepository = ref.read(authRepositoryProvider);

//     return AppState.initial();
//   }

//   void execute(String email) async {
//     notifyOnLoading();

//     final res = await _authRepository.forgotPassword(email);

//     res.fold(
//       (l) {
//         notifyOnError(error: l, state_: state);
//       },
//       (r) {
//         notifyOnSuccess(state_: state);
//       },
//     );
//   }
// }
