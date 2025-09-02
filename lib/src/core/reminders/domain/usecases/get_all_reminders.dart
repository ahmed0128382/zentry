import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
import 'package:zentry/src/core/reminders/domain/repos/reminder_repo.dart';
import 'package:zentry/src/shared/infrastructure/utils/guard.dart';

class GetAllReminders {
  final ReminderRepo repository;

  GetAllReminders(this.repository);

  Future<Result<List<Reminder>>> call() {
    return repository.getAllReminders();
  }
}
