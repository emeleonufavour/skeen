import 'package:skeen/cores/cores.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/features/features.dart';

final getTipsAndTrickNotifier = NotifierProvider<GetTipsAndTrickNotifier,
    AppState<List<TipsAndTricksEntity>>>(
  GetTipsAndTrickNotifier.new,
);

class GetTipsAndTrickNotifier
    extends Notifier<AppState<List<TipsAndTricksEntity>>>
    with NotifierHelper<List<TipsAndTricksEntity>> {
  late final HomeRepository _homeRepository;

  @override
  AppState<List<TipsAndTricksEntity>> build() {
    _homeRepository = ref.read(homeRepositoryProvider);

    return AppState.initial();
  }

  void execute() async {
    final res = await _homeRepository.getTipsAndTricks();

    res.fold(
      (l) {
        notifyOnError(error: l, state_: state);
      },
      (r) {
        AppLogger.logWarning("Tips and Tricks: $r");
        notifyOnSuccess(state_: state, data: r);
      },
    );
  }
}
