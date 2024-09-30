import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:myskin_flutterbytes/firebase_options.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';

class Setup {
  static Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

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
