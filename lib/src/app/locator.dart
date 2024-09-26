import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../cores/utils/session_manager.dart';

class SetUpLocators {
  static const SetUpLocators _instance = SetUpLocators._();
  const SetUpLocators._();
  factory SetUpLocators() => _instance;

  static final getIt = GetIt.instance;

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(LOCAL_CACHE_BOX);

    getIt.registerLazySingleton<SessionManager>(() => SessionManager());
  }
}
