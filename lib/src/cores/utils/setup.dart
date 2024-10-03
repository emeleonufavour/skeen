import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:myskin_flutterbytes/src/cores/cores.dart';

class Setup {
  static Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();

    await svgPrecacheImage();

    await Hive.initFlutter();
    await Hive.openBox(localCacheBox);

    final localNotificationService = LocalNotificationService();
    await localNotificationService.initializeNotifications();
    await localNotificationService.requestPermissions();

    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }
}
