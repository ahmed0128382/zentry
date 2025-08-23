// File: src/features/habits/application/controllers/habit_reminders_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_reminder.dart';
import 'package:zentry/src/features/habits/domain/repos/habit_reminders_repo.dart';

class HabitRemindersController
    extends StateNotifier<AsyncValue<List<HabitReminder>>> {
  final HabitRemindersRepo _repo;

  HabitRemindersController(this._repo) : super(const AsyncValue.loading());

  Future<void> loadReminders(String habitId) async {
    state = const AsyncValue.loading();
    final result = await _repo.getForHabit(habitId);
    state = result.fold(
      (e) => AsyncValue.error(e, StackTrace.current),
      (reminders) => AsyncValue.data(reminders),
    );
  }

  Future<void> addReminder(HabitReminder reminder) async {
    final result = await _repo.add(reminder);
    result.fold(
      (e) => state = AsyncValue.error(e, StackTrace.current),
      (r) => state.whenData((list) => state = AsyncValue.data([...list, r])),
    );
  }

  Future<void> updateReminder(HabitReminder reminder) async {
    final result = await _repo.update(reminder);
    result.fold(
      (e) => state = AsyncValue.error(e, StackTrace.current),
      (r) => state.whenData((list) {
        final updated = [...list.where((rem) => rem.id != r.id), r];
        state = AsyncValue.data(updated);
      }),
    );
  }

  Future<void> deleteReminder(String reminderId) async {
    final result = await _repo.delete(reminderId);
    result.fold(
      (e) => state = AsyncValue.error(e, StackTrace.current),
      (_) => state.whenData(
        (list) => state =
            AsyncValue.data(list.where((r) => r.id != reminderId).toList()),
      ),
    );
  }
}
