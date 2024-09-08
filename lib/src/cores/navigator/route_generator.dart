import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';
import 'package:myskin_flutterbytes/src/features/chat_bot/chat_bot_view.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';
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
