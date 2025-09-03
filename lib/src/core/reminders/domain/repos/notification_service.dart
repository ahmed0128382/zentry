// File: lib/src/core/reminders/domain/services/notification_service.dart

import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';

abstract class NotificationService {
  /// Show an instant notification
  Future<void> showNotification(Reminder reminder);

  /// Schedule a notification for a specific date/time
  Future<void> scheduleNotification(Reminder reminder,
      {bool repeatWeekly = false});

  /// Cancel a scheduled notification
  Future<void> cancelNotification(Reminder reminder);

  /// Cancel all notifications
  Future<void> cancelAllNotifications();
}
