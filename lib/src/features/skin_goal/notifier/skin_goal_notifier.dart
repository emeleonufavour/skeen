import 'package:flutter_riverpod/flutter_riverpod.dart';

final skinGoalBottomSheetProvider =
    StateNotifierProvider<SkinGoalBottomSheetNotifier, int>((ref) {
  return SkinGoalBottomSheetNotifier();
});

class SkinGoalBottomSheetNotifier extends StateNotifier<int> {
  SkinGoalBottomSheetNotifier() : super(0);

  void setPage(int page) => state = page;
  void nextPage() => state = state < 2 ? state + 1 : state;
  void previousPage() => state = state > 0 ? state - 1 : state;
}
