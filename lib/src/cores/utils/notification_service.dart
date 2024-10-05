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
    final String currentTimeZone = DateTime.now().timeZoneName;
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
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

  Future<void> scheduleDailyNotification(DateTime selectedTime) async {
    AppLogger.log("Scheduling notification for ${selectedTime.toString()}",
        tag: "NotificationService");
    if (selectedTime.isBefore(DateTime.now())) {
      selectedTime = selectedTime.add(const Duration(days: 1));
    }
    final tz.TZDateTime scheduledTime =
        tz.TZDateTime.from(selectedTime, tz.local);

    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "notification title",
        "notification body",
        scheduledTime,
        _notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );

      debugPrint('Notification scheduled successfully');
    } catch (e) {
      debugPrint('Error scheduling notification: $e');
    }
  }

  NotificationDetails _notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        channelDescription: 'your_channel_description',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
      ),
      // iOS: IOSNotificationDetails(),
    );
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

  Future<void> scheduleWeeklyNotification(DateTime selectedTime) async {
    AppLogger.log(
        "Scheduling weekly notification for ${selectedTime.toString()}",
        tag: "NotificationService");

    tz.TZDateTime scheduledTime = _nextInstanceOfWeekday(selectedTime);

    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        1, // Different ID from daily notifications
        "Weekly Notification Title",
        "Weekly Notification Body",
        scheduledTime,
        _notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );

      debugPrint('Weekly notification scheduled successfully');
    } catch (e) {
      debugPrint('Error scheduling weekly notification: $e');
    }
  }

  tz.TZDateTime _nextInstanceOfWeekday(DateTime selectedTime) {
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(selectedTime, tz.local);

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }

    return scheduledDate;
  }

  Future<void> scheduleMonthlyNotification(DateTime selectedTime) async {
    AppLogger.log(
        "Scheduling monthly notification for ${selectedTime.toString()}",
        tag: "NotificationService");

    tz.TZDateTime scheduledTime = _nextInstanceOfMonthlyDate(selectedTime);

    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        2, // Different ID from daily and weekly notifications
        "Monthly Notification Title",
        "Monthly Notification Body",
        scheduledTime,
        _notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
      );

      debugPrint('Monthly notification scheduled successfully');
    } catch (e) {
      debugPrint('Error scheduling monthly notification: $e');
    }
  }

  tz.TZDateTime _nextInstanceOfMonthlyDate(DateTime selectedTime) {
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(selectedTime, tz.local);

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = tz.TZDateTime(
        tz.local,
        scheduledDate.year + (scheduledDate.month == 12 ? 1 : 0),
        scheduledDate.month < 12 ? scheduledDate.month + 1 : 1,
        scheduledDate.day,
        scheduledDate.hour,
        scheduledDate.minute,
      );
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
