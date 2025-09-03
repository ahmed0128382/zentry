import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
import 'package:zentry/src/core/reminders/domain/repos/reminder_repo.dart';
import 'package:zentry/src/core/reminders/domain/repos/notification_service.dart';
import 'package:zentry/src/shared/infrastructure/utils/guard.dart';

class ScheduleReminder {
  final ReminderRepo _repo;
  final NotificationService _notificationService;

  ScheduleReminder(this._repo, this._notificationService);

  Future<Result<void>> call(Reminder reminder,
      {bool repeatWeekly = false}) async {
    return guard(() async {
      // Save in repo
      await _repo.scheduleReminder(reminder);
      // Schedule notification
      await _notificationService.scheduleNotification(reminder,
          repeatWeekly: repeatWeekly);
      return;
    });
  }
}
