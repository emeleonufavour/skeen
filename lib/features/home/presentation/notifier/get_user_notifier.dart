import 'package:skeen/cores/cores.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/features/features.dart';

final userDetailsNotifier =
    NotifierProvider<GetUserNotifier, AppState<UserEntity>>(
  GetUserNotifier.new,
);

class GetUserNotifier extends Notifier<AppState<UserEntity>>
    with NotifierHelper<UserEntity> {
  // late final HomeRepository _homeRepository;

  @override
  AppState<UserEntity> build() {
    // _homeRepository = ref.read(homeRepositoryProvider);

    return AppState.initial();
  }

  void execute() async {
    // final res = await _homeRepository.getUser();

    // res.fold(
    //   (l) {
    //     notifyOnError(error: l, state_: state);
    //   },
    //   (r) {
    //     notifyOnSuccess(state_: state, data: r);
    //   },
    // );
  }
}
