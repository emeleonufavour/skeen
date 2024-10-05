import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';
import 'package:myskin_flutterbytes/src/features/chat_bot/ui/views/chat_bot_view.dart';
import 'package:myskin_flutterbytes/src/features/home/data/model/gemma_response.dart';
import 'package:myskin_flutterbytes/src/features/settings/presentation/views/edit_profile_view.dart';
import 'package:myskin_flutterbytes/src/features/settings/presentation/views/help_view.dart';
import 'package:myskin_flutterbytes/src/features/settings/presentation/views/notification_view.dart';
import 'package:myskin_flutterbytes/src/features/settings/presentation/views/settings_view.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';
import '../../features/camera/presentation/views/camera_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case NavBarView.route:
        return pageRoute(const NavBarView());
      case SkinCareGoalView.route:
        return pageRoute(const SkinCareGoalView());
      case ChatBotView.route:
        final param = args as GemmaResponse?;
        return pageRoute(ChatBotView(response: param));
      case HistoryView.route:
        return pageRoute(const HistoryView());
      case CameraScreen.route:
        return pageRoute(const CameraScreen());
      case SignUpView.route:
        return pageRoute(const SignUpView());
      case SignInView.route:
        return pageRoute(const SignInView());
      case ForgotPasswordView.route:
        return pageRoute(const ForgotPasswordView());
      case OnboardingView.route:
        return pageRoute(const OnboardingView());
      case ScanProductView.route:
        return pageRoute(const ScanProductView());
      case VerificationView.route:
        final mail = args as String;
        return pageRoute(
          VerificationView(mail: mail),
        );
      case ResetPasswordView.route:
        return pageRoute(ResetPasswordView());
      case SplashView.route:
        return pageRoute(const SplashView());
      case MedicalHistoryView.route:
        return pageRoute(const MedicalHistoryView());

      case SettingsView.route:
        return pageRoute(const SettingsView());
      case EditProfileView.route:
        return pageRoute(const EditProfileView());
      case NotificationSettingsView.route:
        return pageRoute(const NotificationSettingsView());
      case HelpSettingsView.route:
        return pageRoute(const HelpSettingsView());

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
