import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/reminders/application/providers/cancel_reminder_provider.dart';
import 'package:zentry/src/core/reminders/application/providers/schedule_reminder_provider.dart';

import '../controllers/habits_controller.dart';
import 'habit_usecases_providers.dart';

final habitsControllerProvider =
    StateNotifierProvider<HabitsController, HabitsState>((ref) {
  return HabitsController(
    getHabitsForDay: ref.read(getHabitsForDayProvider),
    addHabit: ref.read(addHabitProvider),
    updateHabit: ref.read(updateHabitProvider),
    deleteHabit: ref.read(deleteHabitProvider),
    moveHabitToSection: ref.read(moveHabitToSectionProvider),
    reorderHabitsWithinSection: ref.read(reorderHabitsWithinSectionProvider),
    logHabitCompletion: ref.read(logHabitCompletionProvider),
    scheduleReminder: ref.read(scheduleReminderProvider),
    cancelReminder: ref.read(cancelReminderProvider),
  );
});
