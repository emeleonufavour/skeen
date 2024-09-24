import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final Object? args = settings.arguments;

    switch (settings.name) {
      case SplashView.route:
        return pageRoute(const SplashView());

      case NavBarView.route:
        return pageRoute(const NavBarView());

      case SkinCareGoalView.route:
        return pageRoute(const SkinCareGoalView());

      case ChatBotView.route:
        return pageRoute(ChatBotView());

      case HistoryView.route:
        return pageRoute(const HistoryView());

      case BarcodeScannerScreen.route:
        return pageRoute(const BarcodeScannerScreen());

      case SignUpView.route:
        return pageRoute(SignUpView());

      case SignInView.route:
        return pageRoute(SignInView());

      case ForgotPasswordView.route:
        return pageRoute(ForgotPasswordView());

      case OnboardingView.route:
        return pageRoute(const OnboardingView());

      case ScanProductView.route:
        return pageRoute(const ScanProductView());

      default:
        return errorRoute();
    }
  }

  static PageRoute pageRoute(Widget page) {
    if (!kIsWeb && Platform.isIOS) {
      return CupertinoPageRoute(builder: (_) => page);
    }

    return MaterialPageRoute(builder: (_) => page);
  }
}
