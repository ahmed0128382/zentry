// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// /// Singleton notification service compatible with flutter_local_notifications v17+
// class LocalNotificationService {
//   static final LocalNotificationService _instance =
//       LocalNotificationService._internal();
//   factory LocalNotificationService() => _instance;
//   LocalNotificationService._internal();

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   /// Call this in main() before runApp()
//   Future<void> init() async {
//     // Timezone (required for zonedSchedule)
//     tz.initializeTimeZones();

//     // Android init
//     const AndroidInitializationSettings androidInit =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     // iOS init
//     const DarwinInitializationSettings iosInit = DarwinInitializationSettings();

//     // Combine
//     const InitializationSettings initSettings =
//         InitializationSettings(android: androidInit, iOS: iosInit);

//     await flutterLocalNotificationsPlugin.initialize(initSettings);

//     // (Optional) Ask permissions on Android 13+ and iOS
//     await _requestPermissionsIfNeeded();
//   }

//   Future<void> _requestPermissionsIfNeeded() async {
//     // Android 13+ runtime permission
//     final androidImpl =
//         flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>();
//     if (androidImpl != null) {
//       await androidImpl.requestNotificationsPermission();
//     }

//     // iOS permissions
//     final iosImpl =
//         flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>();
//     if (iosImpl != null) {
//       await iosImpl.requestPermissions(alert: true, badge: true, sound: true);
//     }
//   }

//   /// Immediate notification
//   Future<void> showNotification({
//     required int id,
//     required String title,
//     required String body,
//   }) async {
//     const androidDetails = AndroidNotificationDetails(
//       'habit_channel',
//       'Habit Reminders',
//       channelDescription: 'Reminders for your habits',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const details = NotificationDetails(
//       android: androidDetails,
//       iOS: DarwinNotificationDetails(),
//     );

//     await flutterLocalNotificationsPlugin.show(id, title, body, details);
//   }

//   /// Schedule a one-time notification at an exact local time
//   Future<void> scheduleOneTime({
//     required int id,
//     required String title,
//     required String body,
//     required DateTime scheduledDateTime,
//   }) async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.from(scheduledDateTime, tz.local),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'habit_channel',
//           'Habit Reminders',
//           channelDescription: 'Reminders for your habits',
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//         iOS: DarwinNotificationDetails(),
//       ),
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       // No uiLocalNotificationDateInterpretation in v17+
//       // No androidAllowWhileIdle in v17+ (use androidScheduleMode instead)
//     );
//   }

//   /// Schedule a daily recurring notification at [hour]:[minute]
//   Future<void> scheduleDaily({
//     required int id,
//     required String title,
//     required String body,
//     required int hour,
//     required int minute,
//   }) async {
//     final next = _nextInstanceOfTime(hour, minute);
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       next,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'habit_channel',
//           'Habit Reminders',
//           channelDescription: 'Reminders for your habits',
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//         iOS: DarwinNotificationDetails(),
//       ),
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       matchDateTimeComponents: DateTimeComponents.time, // repeats daily
//     );
//   }

//   /// Schedule a weekly recurring notification for a specific weekday and time.
//   /// [weekday] uses Dart's DateTime weekday: 1=Mon ... 7=Sun.
//   Future<void> scheduleWeekly({
//     required int id,
//     required String title,
//     required String body,
//     required int weekday,
//     required int hour,
//     required int minute,
//   }) async {
//     final next = _nextInstanceOfWeekdayTime(weekday, hour, minute);
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       next,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'habit_channel',
//           'Habit Reminders',
//           channelDescription: 'Reminders for your habits',
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//         iOS: DarwinNotificationDetails(),
//       ),
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       matchDateTimeComponents:
//           DateTimeComponents.dayOfWeekAndTime, // repeats weekly
//     );
//   }

//   /// Cancel a single notification by id
//   Future<void> cancel(int id) => flutterLocalNotificationsPlugin.cancel(id);

//   /// Cancel all notifications
//   Future<void> cancelAll() => flutterLocalNotificationsPlugin.cancelAll();

//   // ---------- Helpers ----------

//   tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
//     final now = tz.TZDateTime.now(tz.local);
//     var scheduled =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
//     if (scheduled.isBefore(now)) {
//       scheduled = scheduled.add(const Duration(days: 1));
//     }
//     return scheduled;
//   }

//   tz.TZDateTime _nextInstanceOfWeekdayTime(int weekday, int hour, int minute) {
//     // weekday: 1=Mon ... 7=Sun (DateTime convention)
//     var scheduled = _nextInstanceOfTime(hour, minute);
//     while (scheduled.weekday != weekday) {
//       scheduled = scheduled.add(const Duration(days: 1));
//     }
//     return scheduled;
//   }
// }
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Singleton notification service compatible with flutter_local_notifications v17+
/// Customised for Zentry Habits
class LocalNotificationService {
  static final LocalNotificationService _instance =
      LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Callback when user taps notification
  void Function(String? payload)? onNotificationTap;

  /// Call this in main() before runApp()
  Future<void> init({
    void Function(String? payload)? onTap,
  }) async {
    tz.initializeTimeZones();

    onNotificationTap = onTap;

    // Android init
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS init
    const DarwinInitializationSettings iosInit = DarwinInitializationSettings();

    // Combine
    const InitializationSettings initSettings =
        InitializationSettings(android: androidInit, iOS: iosInit);

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (onNotificationTap != null) {
          onNotificationTap!(payload);
        }
      },
    );

    await _requestPermissionsIfNeeded();
  }

  Future<void> _requestPermissionsIfNeeded() async {
    final androidImpl =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl != null) {
      await androidImpl.requestNotificationsPermission();
    }

    final iosImpl =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    if (iosImpl != null) {
      await iosImpl.requestPermissions(alert: true, badge: true, sound: true);
    }
  }

  /// Quick show
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'habit_channel',
      'Habit Reminders',
      channelDescription: 'Reminders for your habits',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }

  /// Schedule notification for a habit reminder
  /// [habitId] + [reminderId] saved as payload
  Future<void> scheduleHabitReminder({
    required int habitId,
    required int reminderId,
    required String title,
    required String body,
    required DateTime scheduledDateTime,
    bool repeatWeekly = false,
  }) async {
    final payload = jsonEncode({
      'habitId': habitId,
      'reminderId': reminderId,
    });

    await flutterLocalNotificationsPlugin.zonedSchedule(
      _makeNotificationId(habitId, reminderId),
      title,
      body,
      tz.TZDateTime.from(scheduledDateTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'habit_channel',
          'Habit Reminders',
          channelDescription: 'Reminders for your habits',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents:
          repeatWeekly ? DateTimeComponents.dayOfWeekAndTime : null,
      payload: payload,
    );
  }

  /// Cancel a reminder notification
  Future<void> cancelByReminder(int habitId, int reminderId) async {
    await flutterLocalNotificationsPlugin
        .cancel(_makeNotificationId(habitId, reminderId));
  }

  /// Cancel all
  Future<void> cancelAll() => flutterLocalNotificationsPlugin.cancelAll();

  // ---------- Helpers ----------

  int _makeNotificationId(int habitId, int reminderId) {
    // combine safely
    return habitId * 1000 + reminderId;
  }
}
