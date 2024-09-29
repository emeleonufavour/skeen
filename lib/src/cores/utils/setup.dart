import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:myskin_flutterbytes/src/cores/cores.dart';

import 'notification_helper.dart';
import 'session_manager.dart';

class Setup {
  static Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();

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
