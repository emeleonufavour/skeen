import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:skeen/cores/cores.dart';

import 'package:skeen/features/features.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case SplashView.route:
        return pageRoute(const SplashView());

      case OnboardingView.route:
        return pageRoute(const OnboardingView());

      // case SignInView.route:
      //   return pageRoute(const SignInView());

      // case SignUpView.route:
      //   return pageRoute(const SignUpView());

      // case ForgotPasswordView.route:
      //   return pageRoute(const ForgotPasswordView());

      // case VerificationView.route:
      //   final String mail = args as String;
      //   return pageRoute(
      //     VerificationView(mail: mail),
      //   );

      case MedicalHistoryView.route:
        return pageRoute(const MedicalHistoryView());

      case MedicalInfoView.route:
        return pageRoute(const MedicalInfoView());

      case NavBarView.route:
        return pageRoute(const NavBarView());

      case CameraView.route:
        return pageRoute(const CameraView());

      case SkincareGoalsView.route:
        return pageRoute(const SkincareGoalsView());

      case ChatBotView.route:
        final param = args as GemmaResponse?;
        return pageRoute(ChatBotView(response: param));

      case SettingsView.route:
        return pageRoute(const SettingsView());
      case EditProfileView.route:
        return pageRoute(const EditProfileView());

      case HelpSettingsView.route:
        return pageRoute(const HelpSettingsView());

      case TrackProductView.route:
        return pageRoute(const TrackProductView());

      case AppIconScreen.route:
        return pageRoute(const AppIconScreen());

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
