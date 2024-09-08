import 'dart:developer';

import 'package:flutter/foundation.dart';

enum ColorLogger {
  black("30"),
  red("31"),
  green("32"),
  yellow("33"),
  blue("34"),
  magenta("35"),
  cyan("36"),
  white("37");

  final String code;
  const ColorLogger(this.code);

  void logger(dynamic text) {
    if (kDebugMode) {
      log('\x1B[${code}m$text\x1B[0m');
    }
  }
}

class AppLogger {
  static void log(String message, {String? tag}) {
    if (kDebugMode) {
      ColorLogger.green.logger("[ 📌📌📌 ${tag ?? 'No tag'}: $message]");
    }
  }

  static void logError(String message, {String? tag}) {
    if (kDebugMode) {
      ColorLogger.red.logger("[ 🚨🚨🚨 ${tag ?? 'No tag'}: $message]");
    }
  }

  static void logSuccess(String message, {String? tag}) {
    if (kDebugMode) {
      ColorLogger.green.logger("[✅✅✅ ${tag ?? 'No tag'}: $message]");
    }
  }

  static void logWarning(String message, {String? tag}) {
    if (kDebugMode) {
      ColorLogger.yellow.logger(
        """
        [⚡⚡⚡ ${tag ?? 'No tag'} :$message]""",
      );
    }
  }
}
