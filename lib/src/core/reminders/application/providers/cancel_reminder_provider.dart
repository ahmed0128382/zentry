import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/reminders/domain/usecases/cancel_reminder.dart';
import 'reminder_repo_provider.dart';
import 'notification_service_provider.dart';

final cancelReminderProvider = Provider<CancelReminder>((ref) {
  final repo = ref.watch(reminderRepoProvider);
  final notificationService = ref.watch(notificationServiceProvider);
  return CancelReminder(repo, notificationService);
});
