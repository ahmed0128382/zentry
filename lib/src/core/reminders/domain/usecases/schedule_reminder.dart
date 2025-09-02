// File: lib/src/core/reminders/domain/usecases/schedule_reminder.dart
import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
import 'package:zentry/src/core/reminders/domain/repos/reminder_repo.dart';
import 'package:zentry/src/shared/infrastructure/utils/guard.dart';

class ScheduleReminder {
  final ReminderRepo _repo;

  ScheduleReminder(this._repo);

  Future<Result<void>> call(Reminder reminder) async {
    return _repo.scheduleReminder(reminder);
  }
}
