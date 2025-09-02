import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
import 'package:zentry/src/core/reminders/domain/repos/reminder_repo.dart';
import 'package:zentry/src/shared/infrastructure/utils/guard.dart';

/// Temporary in-memory storage until we hook up real notification service + database.
final Map<String, Reminder> _reminderStore = {};

class ReminderRepositoryImpl implements ReminderRepo {
  @override
  Future<Result<void>> scheduleReminder(Reminder reminder) {
    return guard(() async {
      _reminderStore[reminder.id] = reminder;
      // TODO: integrate flutter_local_notifications to actually schedule
      return;
    });
  }

  @override
  Future<Result<void>> cancelReminder(String reminderId) {
    return guard(() async {
      _reminderStore.remove(reminderId);
      // TODO: cancel from flutter_local_notifications
      return;
    });
  }

  @override
  Future<Result<List<Reminder>>> getAllReminders() {
    return guard(() async {
      return _reminderStore.values.toList();
    });
  }

  @override
  Future<Result<List<Reminder>>> getRemindersForHabit(String habitId) {
    return guard(() async {
      return _reminderStore.values
          .where((r) => r.ownerType == 'habit' && r.ownerId == habitId)
          .toList();
    });
  }
}
