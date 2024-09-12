import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';
import 'package:myskin_flutterbytes/src/features/auth/views/forgot_password.dart';
import 'package:myskin_flutterbytes/src/features/auth/views/signin_view.dart';
import 'package:myskin_flutterbytes/src/features/auth/views/signup_view.dart';
import 'package:myskin_flutterbytes/src/features/chat_bot/ui/views/chat_bot_view.dart';
import 'package:myskin_flutterbytes/src/features/scan_product/presentation/ui/views/scan_product_camera.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';
import 'package:myskin_flutterbytes/src/features/history/views/history_view.dart';
import 'package:myskin_flutterbytes/src/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:myskin_flutterbytes/src/features/scan_product/presentation/ui/views/scan_product_view.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/views/skin_goal_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final Object? args = settings.arguments;

    switch (settings.name) {
      case NavBarView.route:
        return pageRoute(const NavBarView());
      case SkinCareGoalView.route:
        return pageRoute(const SkinCareGoalView());
      case ChatBotView.route:
        return pageRoute(const ChatBotView());
      case HistoryView.route:
        return pageRoute(const HistoryView());
      case BarcodeScannerScreen.route:
        return pageRoute(BarcodeScannerScreen());
      case SignUpView.route:
        return pageRoute(SignUpView());
      case SigninView.route:
        return pageRoute(SigninView());
      case ForgotPasswordView.route:
        return pageRoute(ForgotPasswordView());
      case OnboardingView.route:
        return pageRoute(OnboardingView());
      case ScanProductView.route:
        return pageRoute(ScanProductView());
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
