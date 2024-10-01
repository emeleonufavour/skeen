import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../cores/utils/notification_service.dart';
import '../cores/utils/session_manager.dart';

class SetUpLocators {
  static const SetUpLocators _instance = SetUpLocators._();
  const SetUpLocators._();
  factory SetUpLocators() => _instance;

  static final getIt = GetIt.instance;

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(LOCAL_CACHE_BOX);

    final localNotificationService = LocalNotificationService();
    await localNotificationService.initializeNotifications();
    await localNotificationService.requestPermissions();

    localNotificationService.showSimpleNotification(
        title: "Success",
        body: "You have successfully implemented local",
        payload: "payload");

    getIt.registerLazySingleton<SessionManager>(() => SessionManager());
    getIt.registerLazySingleton<LocalNotificationService>(
        () => localNotificationService);
  }
}
