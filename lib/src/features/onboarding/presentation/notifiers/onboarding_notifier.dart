import '../../onboarding.dart';

final onboardingProvider = StateNotifierProvider<OnboardingNotifier, int>(
  (ref) {
    final sessionManager = ref.read(sessionManagerProvider);
    return OnboardingNotifier(sessionManager);
  },
);

class OnboardingNotifier extends StateNotifier<int> {
  OnboardingNotifier(this.sessionManager) : super(0);
  final SessionManager sessionManager;

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

  void setUserOnboardStatusToTrue() async {
    await sessionManager.storeBool(isOnboardKey, true);
  }
}

const isOnboardKey = "is_onboard";
const isLoggedInKey = "is_logged_in";
