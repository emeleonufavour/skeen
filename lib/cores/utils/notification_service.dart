import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';
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
    tz.setLocalLocation(tz.local);
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  String _getDayName(int weekday) {
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[weekday - 1];
  }

  NotificationDetails _routineNotificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'skincare_routine_channel',
        'Skincare Routines',
        channelDescription: 'Notifications for skincare routine reminders',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
      ),
      iOS: DarwinNotificationDetails(),
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

  Future<void> scheduleDailyNotification(
    DateTime scheduledTime, {
    required SkinGoalCategory category,
    required String routineName,
    required int timeIndex,
  }) async {
    final int notificationId = NotificationIds.generate(
      category: category,
      timeIndex: timeIndex,
    );

    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        NotificationContent.getTitle(routineName),
        NotificationContent.getBody(routineName, 'daily'),
        tz.TZDateTime.from(scheduledTime, tz.local),
        _routineNotificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );

      AppLogger.log(
          'Daily notification scheduled for $routineName at ${scheduledTime.toString()} with ID $notificationId',
          tag: 'NotificationService');
    } catch (e) {
      AppLogger.logError('Error scheduling daily notification: $e',
          tag: 'NotificationService');
    }
  }

  Future<void> scheduleWeeklyNotification(
    DateTime scheduledTime, {
    required SkinGoalCategory category,
    required String routineName,
    required int timeIndex,
    required int dayIndex,
  }) async {
    final int notificationId = NotificationIds.generate(
      category: category,
      timeIndex: timeIndex,
      dayIndex: dayIndex,
    );

    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        NotificationContent.getTitle(routineName),
        NotificationContent.getBody(routineName, 'weekly'),
        tz.TZDateTime.from(scheduledTime, tz.local),
        _routineNotificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );

      AppLogger.log(
          'Weekly notification scheduled for $routineName on ${_getDayName(scheduledTime.weekday)} at ${scheduledTime.toString()} with ID $notificationId',
          tag: 'NotificationService');
    } catch (e) {
      AppLogger.logError('Error scheduling weekly notification: $e',
          tag: 'NotificationService');
    }
  }

  Future<void> scheduleMonthlyNotification(
    DateTime scheduledTime, {
    required SkinGoalCategory category,
    required String routineName,
    required int timeIndex,
  }) async {
    final int notificationId = NotificationIds.generate(
      category: category,
      timeIndex: timeIndex,
    );

    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        NotificationContent.getTitle(routineName),
        NotificationContent.getBody(routineName, 'monthly'),
        tz.TZDateTime.from(scheduledTime, tz.local),
        _routineNotificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
      );

      AppLogger.log(
          'Monthly notification scheduled for $routineName on day ${scheduledTime.day} at ${scheduledTime.toString()} with ID $notificationId',
          tag: 'NotificationService');
    } catch (e) {
      AppLogger.logError('Error scheduling monthly notification: $e',
          tag: 'NotificationService');
    }
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

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    try {
      final List<PendingNotificationRequest> pendingNotifications =
          await flutterLocalNotificationsPlugin.pendingNotificationRequests();

      AppLogger.log(
          'Found ${pendingNotifications.length} pending notifications',
          tag: 'NotificationService');

      return pendingNotifications;
    } catch (e) {
      AppLogger.logError('Error getting pending notifications: $e',
          tag: 'NotificationService');
      return [];
    }
  }

  Future<void> cancelNotificationById(int id) async {
    try {
      await flutterLocalNotificationsPlugin.cancel(id);
      AppLogger.log('Cancelled notification with ID: $id',
          tag: 'NotificationService');
    } catch (e) {
      AppLogger.logError('Error cancelling notification with ID $id: $e',
          tag: 'NotificationService');
    }
  }

  Future<void> cancelAllNotifications() async {
    try {
      await flutterLocalNotificationsPlugin.cancelAll();
      AppLogger.log('All notifications cancelled successfully',
          tag: 'NotificationService');
    } catch (e) {
      AppLogger.logError('Error cancelling all notifications: $e',
          tag: 'NotificationService');
    }
  }
}
