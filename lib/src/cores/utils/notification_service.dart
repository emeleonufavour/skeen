import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

final notificationServiceProvider = Provider<LocalNotificationService>(
  (ref) => LocalNotificationService(),
);

class LocalNotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  LocalNotificationService() {
    initializeNotifications();
  }

  Future<void> initializeNotifications() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            // requestAlertPermission: false,
            // requestBadgePermission: false,
            // requestSoundPermission: false,
            );
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> requestPermissions() async {
    if (Platform.isAndroid) {
      return _requestPermissionsOnAndroid();
    } else if (Platform.isIOS) {
      return _requestPermissionsOnIOS();
    } else {
      AppLogger.logError("Current platform is not supported");
    }
  }

  Future<void> _requestPermissionsOnAndroid() async {
    AppLogger.log("Request notification permission on Android");
    final platform =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (platform != null) {
      await platform.requestNotificationsPermission();
    }
  }

  Future<void> _requestPermissionsOnIOS() async {
    AppLogger.log("Request notification permission on IOS");
    final platform =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    if (platform != null) {
      await platform.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  Future showSimpleNotification(
      {required String title,
      required String body,
      required String payload}) async {
    AppLogger.log("Show simple notification");
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  Future<void> scheduleDaily(
      int id, String title, String body, TimeOfDay time) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(time),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_notification_channel',
          'Daily Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleWeekly(
      int id, String title, String body, TimeOfDay time, int day) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfWeekday(time, day),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'weekly_notification_channel',
          'Weekly Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  Future<void> scheduleMonthly(
      int id, String title, String body, TimeOfDay time, int day) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfMonthlyDay(time, day),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'monthly_notification_channel',
          'Monthly Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfWeekday(TimeOfDay time, int day) {
    tz.TZDateTime scheduledDate = _nextInstanceOfTime(time);
    while (scheduledDate.weekday != day) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfMonthlyDay(TimeOfDay time, int day) {
    tz.TZDateTime scheduledDate = _nextInstanceOfTime(time);
    while (scheduledDate.day != day) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> scheduleReminderBefore({
    required int id,
    required String title,
    required String body,
    required DateTime targetDate,
    required Duration reminderPeriod,
  }) async {
    final notificationDate = targetDate.subtract(reminderPeriod);

    if (notificationDate.isBefore(DateTime.now())) {
      AppLogger.logWarning(
          'You are attempting to schedule notification in the past');
      return;
    }

    final tz.TZDateTime scheduledDate =
        tz.TZDateTime.from(notificationDate, tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_notification_channel',
          'Reminder Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> scheduleOneWeekBefore({
    required int id,
    required String title,
    required String body,
    required DateTime targetDate,
  }) async {
    await scheduleReminderBefore(
      id: id,
      title: title,
      body: body,
      targetDate: targetDate,
      reminderPeriod: const Duration(days: 7),
    );
  }

  Future<void> scheduleTwoWeeksBefore({
    required int id,
    required String title,
    required String body,
    required DateTime targetDate,
  }) async {
    await scheduleReminderBefore(
      id: id,
      title: title,
      body: body,
      targetDate: targetDate,
      reminderPeriod: const Duration(days: 14),
    );
  }

  Future<void> scheduleOneMonthBefore({
    required int id,
    required String title,
    required String body,
    required DateTime targetDate,
  }) async {
    await scheduleReminderBefore(
      id: id,
      title: title,
      body: body,
      targetDate: targetDate,
      reminderPeriod: const Duration(days: 30),
    );
  }
}
