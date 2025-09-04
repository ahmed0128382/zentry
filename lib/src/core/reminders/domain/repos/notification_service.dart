import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';

abstract class NotificationService {
  /// Show an instant notification
  Future<void> showNotification(Reminder reminder);

  /// Schedule a notification.
  ///
  /// - If [reminder.weekdays] is empty → schedules daily at the given time.
  /// - If [reminder.weekdays] has values → schedules weekly on those weekdays.
  // Future<void> scheduleNotification(Reminder reminder);
  Future<void> scheduleNotification(
      {required int id,
      required String title,
      required String body,
      required int hour,
      required int minute});

  /// Cancel a scheduled notification
  Future<void> cancelNotification(Reminder reminder);

  /// Cancel all notifications
  Future<void> cancelAllNotifications();
}
