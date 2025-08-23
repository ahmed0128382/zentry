// Provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/application/controllers/habit_reminders_controller.dart';
import 'package:zentry/src/features/habits/application/providers/habit_reminders_repo_provider.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_reminder.dart';

final habitRemindersControllerProvider = StateNotifierProvider<
    HabitRemindersController, AsyncValue<List<HabitReminder>>>((ref) {
  return HabitRemindersController(ref.read(habitRemindersRepoProvider));
});
