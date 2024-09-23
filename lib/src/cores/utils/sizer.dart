import 'dart:math';

import 'package:myskin_flutterbytes/src/cores/cores.dart';

BuildContext? get safeContext => navigatorKey.currentContext;

double get screenWidth =>
    safeContext != null ? MediaQuery.sizeOf(safeContext!).width : 375;
double get screenHeight =>
    safeContext != null ? MediaQuery.sizeOf(safeContext!).height : 812;

extension Sizers on num {
  SizedBox get verticalSpace {
    return switch (screenWidth > Config.breakpoint) {
      true => SizedBox(height: toDouble()),
      false => SizedBox(
          height: ((screenHeight / Config.baseHeight) * this).toDouble()),
    };
  }

  SizedBox get horizontalSpace {
    return switch (screenWidth > Config.breakpoint) {
      true => SizedBox(width: toDouble()),
      false =>
        SizedBox(width: ((screenWidth / Config.baseWidth) * this).toDouble()),
    };
  }

  double get sp {
    return switch (screenWidth > Config.breakpoint) {
      true => MediaQuery.of(safeContext!).textScaler.scale(toDouble()),
      false => (min(
            screenWidth / Config.baseWidth,
            screenHeight / Config.baseHeight,
          )) *
          MediaQuery.of(safeContext!).textScaler.scale(toDouble()),
    };
  }

  double get h {
    return switch (screenWidth > Config.breakpoint) {
      true => toDouble(),
      false => ((screenHeight / Config.baseHeight) * this).toDouble(),
    };
  }

  double get w {
    return switch (screenWidth > Config.breakpoint) {
      true => toDouble(),
      false => ((screenWidth / Config.baseWidth) * this).toDouble(),
    };
  }
}

class Config {
  static double breakpoint = 640;
  static double baseWidth = 375;
  static double baseHeight = 812;
}
