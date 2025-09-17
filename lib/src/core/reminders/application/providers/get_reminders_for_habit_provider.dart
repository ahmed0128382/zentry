import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/reminders/domain/usecases/get_reminders_for_habit.dart';
import 'reminder_repo_provider.dart';

final getRemindersForHabitProvider = Provider<GetRemindersForHabit>((ref) {
  final repo = ref.watch(reminderRepoProvider);
  return GetRemindersForHabit(repo);
});
