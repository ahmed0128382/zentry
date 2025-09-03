import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
import 'package:zentry/src/core/reminders/domain/repos/reminder_repo.dart';
import 'package:zentry/src/core/reminders/domain/repos/notification_service.dart';
import 'package:zentry/src/shared/infrastructure/utils/guard.dart';

class CancelReminder {
  final ReminderRepo _repo;
  final NotificationService _notificationService;

  CancelReminder(this._repo, this._notificationService);

  Future<Result<void>> call(Reminder reminder) async {
    return guard(() async {
      // Remove from repo
      await _repo.cancelReminder(reminder.id);
      // Cancel notification

      await _notificationService.cancelNotification(reminder);
      return;
    });
  }
}
