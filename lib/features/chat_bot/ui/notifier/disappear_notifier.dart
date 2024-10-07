import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisappearNotifier extends StateNotifier<bool> {
  DisappearNotifier() : super(false);

  void toggle() {
    state = !state;
  }

  void reset() {
    state = false;
  }
}

final disappearProvider = StateNotifierProvider<DisappearNotifier, bool>((ref) {
  return DisappearNotifier();
});
