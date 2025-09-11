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
// File: src/core/reminders/infrastructure/repos/local_notification_service_impl.dart
import 'dart:developer';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
import 'package:zentry/src/core/reminders/domain/repos/notification_service.dart';
import 'package:zentry/src/core/reminders/infrastructure/repos/exact_alarm_helper.dart';

class LocalNotificationServiceImpl implements NotificationService {
  // static final LocalNotificationServiceImpl _instance =
  //     LocalNotificationServiceImpl._internal();
  // factory LocalNotificationServiceImpl() => _instance;
  // LocalNotificationServiceImpl._internal();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation(await FlutterTimezone.getLocalTimezone()));
  }

  static Future senSimpleNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', notificationDetails,
        payload: 'item x');
  }

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
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
    return null;
  }

  static Future<bool?> requestExactAlarmPermission() async {
    if (Platform.isAndroid) {
      return await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestExactAlarmsPermission();
    } else if (Platform.isIOS) {
      return true;
    }
    return null;
  }

  static Future cancelllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  @override
  Future<void> cancelAllNotifications() {
    throw UnimplementedError();
  }

  @override
  Future<void> cancelNotification(Reminder reminder) {
    throw UnimplementedError();
  }

  @override
  Future<void> scheduleNotification(Reminder reminder) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails();
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        'title',
        'body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time);
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
      reminder.title,
      reminder.body,
      details,
      payload: reminder.toPayloadJson(),
    );

    log('Immediate notification shown: ${reminder.title}');
  }

  Future<void> startPeriodicNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails();
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'periodic title',
      'periodic body',
      RepeatInterval.everyMinute,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // void Function(String? payload)? onNotificationTap;

  // Future<void> init({void Function(String? payload)? onTap}) async {
  //   onNotificationTap = onTap;

  //   tz.initializeTimeZones();
  //   final timeZoneName = await FlutterTimezone.getLocalTimezone();
  //   tz.setLocalLocation(tz.getLocation(timeZoneName));
  //   log('Timezone set to: $timeZoneName');

  //   const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  //   const iosInit = DarwinInitializationSettings(
  //     requestAlertPermission: true,
  //     requestBadgePermission: true,
  //     requestSoundPermission: true,
  //   );

  //   await _flutterLocalNotificationsPlugin.initialize(
  //     const InitializationSettings(android: androidInit, iOS: iosInit),
  //     onDidReceiveNotificationResponse: (response) {
  //       if (onNotificationTap != null) onNotificationTap!(response.payload);
  //     },
  //   );

  //   await _requestPermissions();
  // }

  // Future<void> _requestPermissions() async {
  //   if (Platform.isAndroid) {
  //     final androidImpl = _flutterLocalNotificationsPlugin
  //         .resolvePlatformSpecificImplementation<
  //             AndroidFlutterLocalNotificationsPlugin>();
  //     final granted = await androidImpl?.requestNotificationsPermission();
  //     log('Android notifications permission granted: $granted');

  //     final allowed = await ExactAlarmHelper.canScheduleExactAlarms();
  //     log('Can schedule exact alarms: $allowed');
  //     if (!allowed) {
  //       await ExactAlarmHelper.requestExactAlarmPermission();
  //     }
  //   }

  //   if (Platform.isIOS) {
  //     final iosImpl = _flutterLocalNotificationsPlugin
  //         .resolvePlatformSpecificImplementation<
  //             IOSFlutterLocalNotificationsPlugin>();
  //     final iosGranted = await iosImpl?.requestPermissions(
  //         alert: true, badge: true, sound: true);
  //     log('iOS notifications permission granted: $iosGranted');
  //   }
  // }

  // @override
  // Future<void> showNotification(Reminder reminder) async {
  //   final details = NotificationDetails(
  //     android: AndroidNotificationDetails(
  //       'habit_channel',
  //       'Habit Reminders',
  //       channelDescription: 'Reminders for your habits',
  //       importance: Importance.max,
  //       priority: Priority.high,
  //     ),
  //     iOS: const DarwinNotificationDetails(
  //       presentAlert: true,
  //       presentBadge: true,
  //       presentSound: true,
  //     ),
  //   );

  //   await _flutterLocalNotificationsPlugin.show(
  //     reminder.computeNotificationId(),
  //     reminder.title,
  //     reminder.body,
  //     details,
  //     payload: reminder.toPayloadJson(),
  //   );

  //   log('Immediate notification shown: ${reminder.title}');
  // }

  // @override
  // Future<void> scheduleNotification(Reminder reminder) async {
  //   final now = tz.TZDateTime.now(tz.local);

  //   // Schedule 10 seconds later
  //   final scheduledDate = now.add(const Duration(seconds: 20));

  //   log('Scheduling notification: ${reminder.title} at $scheduledDate');

  //   await _flutterLocalNotificationsPlugin.zonedSchedule(
  //     reminder.computeNotificationId(),
  //     reminder.title,
  //     reminder.body,
  //     scheduledDate,
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'habit_channel',
  //         'Habit Reminders',
  //         channelDescription: 'Reminders for your habits',
  //         importance: Importance.max,
  //         priority: Priority.high,
  //       ),
  //       iOS: DarwinNotificationDetails(
  //         presentAlert: true,
  //         presentBadge: true,
  //         presentSound: true,
  //       ),
  //     ),
  //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //     matchDateTimeComponents: DateTimeComponents.time,
  //   );

  //   log('Notification scheduled successfully for $scheduledDate');
  // }

  // @override
  // Future<void> cancelNotification(Reminder reminder) async {
  //   await _flutterLocalNotificationsPlugin
  //       .cancel(reminder.computeNotificationId());
  //   log('Notification canceled: ${reminder.title}');
  // }

  // @override
  // Future<void> cancelAllNotifications() async {
  //   await _flutterLocalNotificationsPlugin.cancelAll();
  //   log('All notifications canceled');
  // }
}
