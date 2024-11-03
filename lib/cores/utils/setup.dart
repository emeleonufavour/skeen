import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skeen/cores/cores.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Setup {
  static Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Supabase.initialize(
      url: 'YOUR_SUPABASE_URL',
      anonKey: 'YOUR_SUPABASE_ANON_KEY',
    );

    await Hive.initFlutter();
    await Hive.openBox(localCacheBox);

    await svgPrecacheImage();

    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }
}
