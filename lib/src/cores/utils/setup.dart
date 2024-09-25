import 'package:flutter/services.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';

import '../../service/notification_service.dart';

class Setup {
  static Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();

    final notificationService = NotificationService();
    await notificationService.initializeNotifications();

    await SetUpLocators.init();

    await svgPrecacheImage();

    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }
}
