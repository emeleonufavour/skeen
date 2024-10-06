import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:skeen/cores/cores.dart';

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardState>(
  (ref) {
    final sessionManager = ref.read(sessionManagerProvider);

    return OnboardingNotifier(sessionManager: sessionManager);
  },
);

class OnboardingNotifier extends StateNotifier<OnboardState> {
  OnboardingNotifier({required this.sessionManager})
      : super(OnboardState.initial());

  late SessionManager sessionManager;

  void setPage(int page) {
    state.copyWith(currentIndex: page);
  }

  void nextPage() {
    if (state.currentIndex < 2) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    }
  }

  void previousPage() {
    if (state.currentIndex > 0) {
      state = state.copyWith(currentIndex: state.currentIndex - 1);
    }
  }

  void setUserOnboardStatusToTrue() async {
    await sessionManager.storeBool(isOnboardKey, true);
  }

  void getOnboardStatus() {
    final isOnboard = sessionManager.getBool(isOnboardKey);
    state = state.copyWith(isOnboard: isOnboard ?? false);
  }
}

class OnboardState {
  final int currentIndex;
  final bool isOnboard;
  OnboardState({
    required this.currentIndex,
    required this.isOnboard,
  });

  OnboardState.initial() : this(currentIndex: 0, isOnboard: false);

  OnboardState copyWith({
    int? currentIndex,
    bool? isOnboard,
  }) {
    return OnboardState(
      currentIndex: currentIndex ?? this.currentIndex,
      isOnboard: isOnboard ?? this.isOnboard,
    );
  }
}

const isOnboardKey = "is_onboard";
const isLoggedInKey = "is_logged_in";
