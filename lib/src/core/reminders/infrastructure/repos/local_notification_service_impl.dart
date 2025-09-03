// File: lib/src/core/reminders/infrastructure/services/local_notification_service_impl.dart

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
import 'package:zentry/src/core/reminders/domain/repos/notification_service.dart';

class LocalNotificationServiceImpl implements NotificationService {
  static final LocalNotificationServiceImpl _instance =
      LocalNotificationServiceImpl._internal();
  factory LocalNotificationServiceImpl() => _instance;
  LocalNotificationServiceImpl._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void Function(String? payload)? onNotificationTap;

  /// Initialize the notification service
  Future<void> init({void Function(String? payload)? onTap}) async {
    tz.initializeTimeZones();
    onNotificationTap = onTap;

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings =
        InitializationSettings(android: androidInit, iOS: iosInit);

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (onNotificationTap != null) onNotificationTap!(payload);
      },
    );

    await _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final androidImpl =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidImpl?.requestNotificationsPermission();

    final iosImpl =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    await iosImpl?.requestPermissions(alert: true, badge: true, sound: true);
  }

  @override
  Future<void> showNotification(Reminder reminder) async {
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'habit_channel',
        'Habit Reminders',
        channelDescription: 'Reminders for your habits',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.show(
      reminder.computeNotificationId(),
      reminder.title,
      reminder.body,
      details,
      payload: reminder.toPayloadJson(),
    );
  }

  @override
  Future<void> scheduleNotification(Reminder reminder,
      {bool repeatWeekly = false}) async {
    final now = DateTime.now();
    final scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      reminder.hour,
      reminder.minute,
    );

    final notificationTime = scheduledTime.isBefore(now)
        ? scheduledTime.add(const Duration(days: 1))
        : scheduledTime;

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'habit_channel',
        'Habit Reminders',
        channelDescription: 'Reminders for your habits',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      reminder.computeNotificationId(),
      reminder.title,
      reminder.body,
      tz.TZDateTime.from(notificationTime, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents:
          repeatWeekly ? DateTimeComponents.dayOfWeekAndTime : null,
      payload: reminder.toPayloadJson(),
    );
  }

  @override
  Future<void> cancelNotification(Reminder reminder) async {
    await _flutterLocalNotificationsPlugin
        .cancel(reminder.computeNotificationId());
  }

  @override
  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
