import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<dynamic> goTo(String routeName, {Object? arguments}) {
  return navigatorKey.currentState!.pushNamed(
    routeName,
    arguments: arguments,
  );
}

Future<dynamic> go(Widget page) {
  return navigatorKey.currentState!.push(
    (!kIsWeb && Platform.isAndroid)
        ? MaterialPageRoute(builder: (context) => page)
        : CupertinoPageRoute(builder: (context) => page),
  );
}

Future<dynamic> goReplace(String routeName) {
  return navigatorKey.currentState!.pushReplacementNamed(routeName);
}

Future<dynamic> clearPath(String routeName, {Object? arguments}) {
  return navigatorKey.currentState!.pushNamedAndRemoveUntil(
    routeName,

    ///similar to (Route route)=> route.settings.name == '/'
    ///where '/' is the last page.
    ModalRoute.withName('/'),
    arguments: arguments,
  );
}

void goBack([Object? result]) {
  final NavigatorState? navigator = navigatorKey.currentState;
  if (navigator != null && navigator.canPop()) {
    return navigator.pop(result);
  } else {
    AppLogger.logWarning(
      "YOU ARE ATTEMPTING TO POP A SCREEN THAT HAS NO SCREEN BEFORE IT!",
    );
  }
}
