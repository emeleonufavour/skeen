import '../../onboarding.dart';

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, int>((ref) {
  return OnboardingNotifier();
});

class OnboardingNotifier extends StateNotifier<int> {
  OnboardingNotifier() : super(0);

  void setPage(int page) => state = page;
  void nextPage() {
    if (state < 2) {
      state++;
    }
  }

  void previousPage() {
    if (state > 0) {
      state--;
    }
  }
}
