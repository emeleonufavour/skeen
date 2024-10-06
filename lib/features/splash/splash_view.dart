import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  static const String route = '/splash_view';

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;

  String traqa = 'Skeen';
  String text = '';
  late int textLength;
  late int _index;
  late bool isForward;
  late Timer timer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(authStateNotifier.notifier).execute();
        ref.read(onboardingProvider.notifier).getOnboardStatus();
      },
    );

    textLength = traqa.length;
    _index = -1;
    isForward = true;
    timer = Timer.periodic(
      duration300,
      (timer) {
        if (isForward) {
          _index++;
          if (_index > textLength) {
            _index--;
            isForward = false;
          }
        }
        setState(() => text = traqa.substring(0, _index));
        if (_index == textLength) {
          timer.cancel();
          _initScaleAnimation();
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      bg: Palette.primaryColor,
      useSingleScroll: false,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Orelega',
                fontSize: kXtremeLarge,
                color: Palette.white,
              ),
            ),
            AnimatedSwitcher(
              duration: duration300,
              switchInCurve: Curves.fastEaseInToSlowEaseOut,
              child: text.length == 5
                  ? ScaleTransition(
                      scale: _expandAnimation,
                      child: const CircleAvatar(
                        radius: 10,
                        backgroundColor: Palette.white,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  void _initScaleAnimation() {
    final isLoggedIn = ref.watch(authStateNotifier).data;
    final isOnboard = ref.watch(onboardingProvider).isOnboard;

    AppLogger.logWarning(
      'IS USER LOGGED IN: $isLoggedIn and is Onboard: $isOnboard',
    );

    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _expandAnimation = Tween<double>(begin: 1, end: screenHeight * .08).animate(
      CurvedAnimation(
        parent: _expandController,
        curve: Curves.linear,
      ),
    );

    Future.delayed(
      duration300,
      () => _expandController.forward(),
    );

    _expandAnimation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          if (isOnboard == true) {
            if (isLoggedIn == true) {
              clearPath(NavBarView.route);
            } else {
              clearPath(SignInView.route);
            }
          } else {
            clearPath(OnboardingView.route);
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _expandController.dispose();
    timer.cancel();
    super.dispose();
  }
}
