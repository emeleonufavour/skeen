import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mockito/mockito.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';
import 'package:myskin_flutterbytes/src/features/auth/presentation/ui/forgot_password.dart';
import 'package:myskin_flutterbytes/src/features/auth/presentation/ui/signin_view.dart';
import 'package:myskin_flutterbytes/src/features/auth/presentation/ui/signup_view.dart';
import 'package:myskin_flutterbytes/src/features/auth/presentation/ui/verification_view.dart';
import 'package:myskin_flutterbytes/src/features/chat_bot/ui/views/chat_bot_view.dart';
import 'package:myskin_flutterbytes/src/features/scan_product/presentation/ui/views/scan_product_camera.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';
import 'package:myskin_flutterbytes/src/features/history/views/history_view.dart';
import 'package:myskin_flutterbytes/src/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:myskin_flutterbytes/src/features/scan_product/presentation/ui/views/scan_product_view.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/ui/views/skin_goals_view.dart';

import '../../features/auth/presentation/ui/reset_password.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final Object? args = settings.arguments;

    switch (settings.name) {
      case NavBarView.route:
        return pageRoute(const NavBarView());
      case SkinCareGoalView.route:
        return pageRoute(const SkinCareGoalView());
      case ChatBotView.route:
        return pageRoute(ChatBotView());
      case HistoryView.route:
        return pageRoute(const HistoryView());
      case BarcodeScannerScreen.route:
        return pageRoute(BarcodeScannerScreen());
      case SignUpView.route:
        return pageRoute(SignUpView());
      case SignInView.route:
        return pageRoute(SignInView());
      case ForgotPasswordView.route:
        return pageRoute(ForgotPasswordView());
      case OnboardingView.route:
        return pageRoute(OnboardingView());
      case ScanProductView.route:
        return pageRoute(const ScanProductView());
      case VerificationView.route:
        return pageRoute(VerificationView());
      case ResetPasswordView.route:
        return pageRoute(ResetPasswordView());
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
