import 'package:flutter/services.dart';
import 'package:skeen/cores/cores.dart';

class AppIconService {
  static const platform = MethodChannel('com.skeen.hack/app_icon');

  static Future<bool> changeAppIcon(String iconName) async {
    try {
      final bool result = await platform.invokeMethod('changeAppIcon', {
        'icon': iconName,
      });
      return result;
    } on PlatformException catch (e) {
      AppLogger.logError('Error changing app icon: ${e.message}');
      return false;
    }
  }
}
