import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
import 'package:zentry/src/core/reminders/domain/repos/reminder_repo.dart';
import 'package:zentry/src/shared/infrastructure/utils/guard.dart';

class GetRemindersForHabit {
  final ReminderRepo repository;

  GetRemindersForHabit(this.repository);

  Future<Result<List<Reminder>>> call(String habitId) {
    return repository.getRemindersForHabit(habitId);
  }
}
