import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/reminders/domain/usecases/schedule_reminder.dart';
import 'reminder_repo_provider.dart';
import 'notification_service_provider.dart';

final scheduleReminderProvider = Provider<ScheduleReminder>((ref) {
  final repo = ref.watch(reminderRepoProvider);
  final notificationService = ref.watch(notificationServiceProvider);
  return ScheduleReminder(repo, notificationService);
});
