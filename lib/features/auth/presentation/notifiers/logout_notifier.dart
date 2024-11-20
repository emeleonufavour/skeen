// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:skeen/cores/cores.dart';
// import 'package:skeen/features/features.dart';

// final logoutNotifier =
//     NotifierProvider<LogOutNotifier, AppState<AuthResultEntity>>(
//   LogOutNotifier.new,
// );

// class LogOutNotifier extends Notifier<AppState<AuthResultEntity>>
//     with NotifierHelper<AuthResultEntity> {
//   late final AuthRepository _authRepository;

//   @override
//   AppState<AuthResultEntity> build() {
//     _authRepository = ref.read(authRepositoryProvider);

//     return AppState.initial();
//   }

//   void execute() async {
//     notifyOnLoading();

//     final res = await _authRepository.signInWithGoogle();

//     res.fold(
//       (l) {
//         notifyOnError(error: l, state_: state);
//       },
//       (r) {
//         notifyOnSuccess(data: r, state_: state);
//       },
//     );
//   }

//   void logOut() async {
//     notifyOnLoading();
//     final res = await _authRepository.logout();

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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

// State notifier for logout process
final logoutProvider =
    StateNotifierProvider<LogoutNotifier, AsyncValue<void>>((ref) {
  return LogoutNotifier(ref.read(authRemoteDataSourceProvider));
});

class LogoutNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthRemoteDataSource _authDataSource;

  LogoutNotifier(this._authDataSource) : super(const AsyncValue.data(null));

  Future<void> logout() async {
    state = const AsyncValue.loading();

    try {
      await _authDataSource.logOut();
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
