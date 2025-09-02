import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/reminders/domain/repos/reminder_repo.dart';
import 'package:zentry/src/core/reminders/infrastructure/repos/reminder_repo_impl.dart';

final reminderRepoProvider = Provider<ReminderRepo>((ref) {
  return ReminderRepositoryImpl();
});
