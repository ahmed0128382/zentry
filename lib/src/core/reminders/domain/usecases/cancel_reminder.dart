import 'package:zentry/src/core/reminders/domain/repos/reminder_repo.dart';
import 'package:zentry/src/shared/infrastructure/utils/guard.dart';

class CancelReminder {
  final ReminderRepo repository;

  CancelReminder(this.repository);

  Future<Result<void>> call(String reminderId) {
    return repository.cancelReminder(reminderId);
  }
}
