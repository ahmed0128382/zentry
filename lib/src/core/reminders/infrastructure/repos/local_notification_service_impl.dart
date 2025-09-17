// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
// import 'package:zentry/src/core/reminders/domain/repos/notification_service.dart';
// import 'package:zentry/src/core/reminders/domain/value_objects/reminder_time.dart';
// import 'package:zentry/src/core/reminders/infrastructure/repos/exact_alarm_helper.dart';

// class LocalNotificationServiceImpl implements NotificationService {
//   static final LocalNotificationServiceImpl _instance =
//       LocalNotificationServiceImpl._internal();
//   factory LocalNotificationServiceImpl() => _instance;
//   LocalNotificationServiceImpl._internal();

//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   void Function(String? payload)? onNotificationTap;

//   Future<void> init({void Function(String? payload)? onTap}) async {
//     onNotificationTap = onTap;

//     tz.initializeTimeZones();
//     final timeZoneName = await FlutterTimezone.getLocalTimezone();
//     final location = tz.getLocation(timeZoneName);
//     tz.setLocalLocation(location);
//     log('Timezone set to: $timeZoneName');

//     const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const iosInit = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );
//     const initSettings =
//         InitializationSettings(android: androidInit, iOS: iosInit);

//     await _flutterLocalNotificationsPlugin.initialize(
//       initSettings,
//       onDidReceiveNotificationResponse: (response) {
//         final payload = response.payload;
//         log('Notification tapped callback triggered with payload: $payload');
//         if (onNotificationTap != null) onNotificationTap!(payload);
//       },
//     );

//     await _requestPermissions();
//   }

//   Future<void> _requestPermissions() async {
//     if (Platform.isAndroid) {
//       final androidImpl = _flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>();
//       final granted = await androidImpl?.requestNotificationsPermission();
//       log('Android notifications permission granted: $granted');

//       final allowed = await ExactAlarmHelper.canScheduleExactAlarms();
//       log('Can schedule exact alarms: $allowed');
//       if (!allowed) {
//         await ExactAlarmHelper.requestExactAlarmPermission();
//       }
//     }

//     final iosImpl =
//         _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>();
//     final iosGranted = await iosImpl?.requestPermissions(
//         alert: true, badge: true, sound: true);
//     log('iOS notifications permission granted: $iosGranted');
//   }

//   @override
//   Future<void> showNotification(Reminder reminder) async {
//     final details = NotificationDetails(
//       android: AndroidNotificationDetails(
//         'habit_channel',
//         'Habit Reminders',
//         channelDescription: 'Reminders for your habits',
//         importance: Importance.max,
//         priority: Priority.high,
//       ),
//       iOS: const DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//       ),
//     );

//     await _flutterLocalNotificationsPlugin.show(
//       reminder.computeNotificationId(),
//       reminder.title,
//       reminder.body,
//       details,
//       payload: reminder.toPayloadJson(),
//     );

//     log('Immediate notification shown: ${reminder.title}');
//   }

//   // @override
//   // Future<void> scheduleNotification({
//   //   required int id,
//   //   required String title,
//   //   required String body,
//   //   required int hour,
//   //   required int minute,
//   // }) async {
//   //   final now = tz.TZDateTime.now(tz.local);
//   //   log('Current time: $now');

//   //   // Schedule +5 seconds for testing
//   //   tz.TZDateTime scheduledDate = now.add(const Duration(seconds: 5));

//   //   log('Scheduling notification: $title at $scheduledDate');

//   //   await _flutterLocalNotificationsPlugin.zonedSchedule(
//   //     id,
//   //     title,
//   //     body,
//   //     scheduledDate,
//   //     const NotificationDetails(
//   //       android: AndroidNotificationDetails(
//   //         'habit_channel',
//   //         'Habit Reminders',
//   //         channelDescription: 'Reminders for your habits',
//   //         importance: Importance.max,
//   //         priority: Priority.high,
//   //       ),
//   //       iOS: DarwinNotificationDetails(
//   //         presentAlert: true,
//   //         presentBadge: true,
//   //         presentSound: true,
//   //       ),
//   //     ),
//   //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

//   //     matchDateTimeComponents: null, // Do not repeat
//   //   );

//   //   log('Notification scheduled successfully for $scheduledDate');

//   //   // Debug: fallback to show immediately after 6 seconds if not fired
//   //   Future.delayed(const Duration(seconds: 6), () async {
//   //     log('Debug fallback: showing notification immediately if not fired');
//   //     await showNotification(Reminder(
//   //       id: id.toString(),
//   //       ownerId: "debug",
//   //       ownerType: "debug",
//   //       time: ReminderTime.fromHMS(hour, minute),
//   //       title: title,
//   //       body: body,
//   //     ));
//   //   });
//   // }
//   @override
//   Future<void> scheduleNotification({
//     required int id,
//     required String title,
//     required String body,
//     required int hour,
//     required int minute,
//   }) async {
//     final now = tz.TZDateTime.now(tz.local);
//     log('Current time: $now');

//     // Schedule 2 minutes from now
//     tz.TZDateTime scheduledDate = now.add(const Duration(minutes: 2));
//     log('Scheduling notification: $title at $scheduledDate');

//     await _flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       scheduledDate,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'habit_channel',
//           'Habit Reminders',
//           channelDescription: 'Reminders for your habits',
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//         iOS: DarwinNotificationDetails(
//           presentAlert: true,
//           presentBadge: true,
//           presentSound: true,
//         ),
//       ),
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

//       matchDateTimeComponents: null, // do not repeat
//     );

//     log('Notification scheduled successfully for $scheduledDate');

//     // Debug: fallback after 2 minutes 10 seconds in case it fails
//     Future.delayed(const Duration(minutes: 2, seconds: 10), () async {
//       log('Debug fallback: showing notification immediately if not fired');
//       await showNotification(Reminder(
//         id: id.toString(),
//         ownerId: "debug",
//         ownerType: "debug",
//         time: ReminderTime.fromHMS(hour, minute),
//         title: title,
//         body: body,
//       ));
//     });
//   }

//   @override
//   Future<void> cancelNotification(Reminder reminder) async {
//     await _flutterLocalNotificationsPlugin
//         .cancel(reminder.computeNotificationId());
//     log('Notification canceled: ${reminder.title}');
//   }

//   @override
//   Future<void> cancelAllNotifications() async {
//     await _flutterLocalNotificationsPlugin.cancelAll();
//     log('All notifications canceled');
//   }
// }
// // File: src/core/reminders/infrastructure/repos/local_notification_service_impl.dart
// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
// import 'package:zentry/src/core/reminders/domain/repos/notification_service.dart';

// class LocalNotificationServiceImpl implements NotificationService {
//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future initialize() async {
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     DarwinInitializationSettings iosInitializationSettings =
//         DarwinInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//       notificationCategories: [
//         DarwinNotificationCategory(
//           'testCategoryId',
//           actions: [
//             DarwinNotificationAction.plain('id_1', 'Action 1'),
//           ],
//           options: {DarwinNotificationCategoryOption.customDismissAction},
//         ),
//       ],
//     );

//     InitializationSettings initializationSettings = InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
//     tz.initializeTimeZones();
//     tz.setLocalLocation(
//         tz.getLocation(await FlutterTimezone.getLocalTimezone()));
//   }

//   static Future senSimpleNotification() async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('your channel id', 'your channel name',
//             channelDescription: 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker',
//             actions: [
//           AndroidNotificationAction(
//             'id_1',
//             'Action 1',
//           ),
//         ]);
//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'plain title', 'plain body', notificationDetails,
//         payload: 'item x');
//   }

//   static Future<bool?> requestNotificationPermission() async {
//     if (Platform.isAndroid) {
//       return await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>()
//           ?.requestNotificationsPermission();
//     } else if (Platform.isIOS) {
//       return await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               IOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(
//             alert: true,
//             badge: true,
//             sound: true,
//           );
//     }
//     return null;
//   }

//   static Future<bool?> requestExactAlarmPermission() async {
//     if (Platform.isAndroid) {
//       return await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>()
//           ?.requestExactAlarmsPermission();
//     } else if (Platform.isIOS) {
//       return true;
//     }
//     return null;
//   }

//   static Future cancelllNotifications() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }

//   @override
//   Future<void> cancelAllNotifications() {
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> cancelNotification(Reminder reminder) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> scheduleNotification(Reminder reminder) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('your channel id', 'your channel name',
//             channelDescription: 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker',
//             actions: [
//           AndroidNotificationAction(
//             'id_1',
//             'Action 1',
//             showsUserInterface: true,
//             // If you want the action to open the app when tapped by the user,
//             // set this to true.
//           ),
//         ]);
//     const DarwinNotificationDetails iosNotificationDetails =
//         DarwinNotificationDetails(
//       categoryIdentifier: 'testCategoryId',
//     );
//     const NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails, iOS: iosNotificationDetails);
//     if (await flutterLocalNotificationsPlugin
//             .resolvePlatformSpecificImplementation<
//                 AndroidFlutterLocalNotificationsPlugin>()
//             ?.requestFullScreenIntentPermission() ==
//         false) {
//       log('Full-screen intent permission denied');
//     }
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         2,
//         'title',
//         'body',
//         tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//         notificationDetails,
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//         matchDateTimeComponents: DateTimeComponents.time);
//   }

//   @override
//   Future<void> showNotification(Reminder reminder) async {
//     final details = NotificationDetails(
//       android: AndroidNotificationDetails(
//         'habit_channel',
//         'Habit Reminders',
//         channelDescription: 'Reminders for your habits',
//         importance: Importance.max,
//         priority: Priority.high,
//       ),
//       iOS: const DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//       ),
//     );

//     await flutterLocalNotificationsPlugin.show(
//       reminder.computeNotificationId(),
//       reminder.title,
//       reminder.body,
//       details,
//       payload: reminder.toPayloadJson(),
//     );

//     log('Immediate notification shown: ${reminder.title}');
//   }

//   Future<void> startPeriodicNotification() async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('your channel id', 'your channel name',
//             channelDescription: 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');
//     const DarwinNotificationDetails iosNotificationDetails =
//         DarwinNotificationDetails();
//     const NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails, iOS: iosNotificationDetails);
//     await flutterLocalNotificationsPlugin.periodicallyShow(
//       0,
//       'periodic title',
//       'periodic body',
//       RepeatInterval.everyMinute,
//       notificationDetails,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     );
//   }

//   Future<void> stopPeriodicNotification() async {
//     await flutterLocalNotificationsPlugin.cancel(0);
//   }

//   @pragma('vm:entry-point')
//   static void notificationTapBackground(NotificationResponse response) {
//     // Note: This function runs in a separate isolate.
//     // You can perform background tasks here if needed.
//     final payload = response.payload;
//     log('Notification tapped in background with payload: $payload');
//   }
// }
// File: src/core/reminders/infrastructure/repos/local_notification_service_impl.dart
import 'dart:developer';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:zentry/src/core/reminders/domain/entities/periodic_types.dart';
import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
import 'package:zentry/src/core/reminders/domain/repos/notification_service.dart';
import 'package:zentry/src/core/reminders/domain/value_objects/reminder_time.dart';

class LocalNotificationServiceImpl implements NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialize notification service
  static Future<void> initialize() async {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings iosInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      notificationCategories: [
        DarwinNotificationCategory(
          'habit_reminder_category',
          actions: [
            DarwinNotificationAction.plain('dismiss', 'Dismiss'),
          ],
          options: {DarwinNotificationCategoryOption.customDismissAction},
        ),
      ],
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    // Timezone setup
    tz.initializeTimeZones();
    final localTz = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(localTz));
  }

  /// Request notifications permission
  static Future<bool?> requestNotificationPermission() async {
    if (Platform.isAndroid) {
      return await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } else if (Platform.isIOS) {
      return await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
    return null;
  }

  /// Request exact alarm permission (Android only)
  static Future<bool?> requestExactAlarmPermission() async {
    if (Platform.isAndroid) {
      return await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestExactAlarmsPermission();
    }
    return true; // iOS doesn’t need it
  }

  // ------------------------
  // NotificationService impl
  // ------------------------

  @override
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    log('All notifications cancelled');
  }

  @override
  Future<void> cancelNotification(Reminder reminder) async {
    final baseId = reminder.computeNotificationId();

    if (reminder.weekdays.isEmpty) {
      // Cancel daily reminder
      await flutterLocalNotificationsPlugin.cancel(baseId);
      log('Cancelled daily reminder with id $baseId');
    } else {
      // Cancel all weekday instances
      for (final weekday in reminder.weekdays) {
        final id = baseId + weekday;
        await flutterLocalNotificationsPlugin.cancel(id);
        log('Cancelled weekly reminder with id $id (weekday $weekday)');
      }
    }
  }

  @override
  Future<void> scheduleNotification(Reminder reminder) async {
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'habit_channel',
        'Habit Reminders',
        channelDescription: 'Reminders for your habits',
        importance: Importance.max,
        priority: Priority.high,
        actions: [
          const AndroidNotificationAction('dismiss', 'Dismiss'),
        ],
      ),
      iOS: const DarwinNotificationDetails(
        categoryIdentifier: 'habit_reminder_category',
      ),
    );

    final baseId = reminder.computeNotificationId();

    if (reminder.weekdays.isEmpty) {
      // Daily reminder
      final scheduled = tz.TZDateTime.from(
        reminder.time.toNextScheduledDateTime(),
        tz.local,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        baseId,
        reminder.title ?? 'Reminder',
        reminder.body ?? '',
        scheduled,
        details,
        matchDateTimeComponents: DateTimeComponents.time,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: reminder.toPayloadJson(),
      );
      log('Daily reminder scheduled at ${reminder.time} with id $baseId');
    } else {
      // Weekly reminders
      for (final weekday in reminder.weekdays) {
        final scheduled = _nextInstanceOfWeekday(reminder.time, weekday);
        final id = baseId + weekday;

        await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          reminder.title ?? 'Reminder',
          reminder.body ?? '',
          scheduled,
          details,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          payload: reminder.toPayloadJson(),
        );
        log('Weekly reminder scheduled for weekday $weekday at ${reminder.time} with id $id');
      }
    }
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
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      reminder.computeNotificationId(),
      reminder.title ?? 'Reminder',
      reminder.body ?? '',
      details,
      payload: reminder.toPayloadJson(),
    );

    log('Immediate notification shown: ${reminder.title}');
  }

  // ------------------------
  // Extra utilities
  // ------------------------

  /// Compute next instance of given [weekday] with [time]
  tz.TZDateTime _nextInstanceOfWeekday(ReminderTime time, int weekday) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );

    while (scheduled.weekday != weekday || scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }

  @override
  Future<void> startPeriodicNotification(Reminder reminder) async {
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'periodic_channel',
        'Periodic Reminders',
        channelDescription: 'Used for recurring habit reminders',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
    );

    // Default to daily repeat
    RepeatInterval interval = RepeatInterval.daily;

    if (reminder.periodicType != null) {
      switch (reminder.periodicType) {
        case PeriodicType.hourly:
          interval = RepeatInterval.hourly;
          break;
        case PeriodicType.weekly:
          interval = RepeatInterval.weekly;
          break;
        default:
          interval = RepeatInterval.daily;
      }
    }

    await flutterLocalNotificationsPlugin.periodicallyShow(
      reminder.computeNotificationId(),
      reminder.title ?? 'Reminder',
      reminder.body ?? 'It’s time!',
      interval,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: reminder.toPayloadJson(),
    );

    log('Started periodic reminder with interval $interval');
  }

  @override
  Future<void> stopPeriodicNotification(Reminder reminder) async {
    await flutterLocalNotificationsPlugin
        .cancel(reminder.computeNotificationId());
    log('Stopped periodic reminder with id ${reminder.computeNotificationId()}');
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(NotificationResponse response) {
    final payload = response.payload;
    log('Notification tapped in background with payload: $payload');
  }
}
