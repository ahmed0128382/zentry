// File: src/features/habits/application/controllers/habit_reminders_controller.dart

import 'dart:developer' as developer;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_reminder.dart';
import 'package:zentry/src/features/habits/domain/repos/habit_reminders_repo.dart';

class HabitRemindersController
    extends StateNotifier<AsyncValue<List<HabitReminder>>> {
  final HabitRemindersRepo _repo;

  HabitRemindersController(this._repo) : super(const AsyncValue.loading());

  /// Load reminders into this controller's state (keeps AsyncValue semantics)
  Future<void> loadReminders(String habitId) async {
    state = const AsyncValue.loading();
    final result = await _repo.getForHabit(habitId);
    state = result.fold(
      (e) {
        developer.log('Failed to load reminders: $e',
            name: 'HabitRemindersController');
        return AsyncValue.error(e, StackTrace.current);
      },
      (reminders) => AsyncValue.data(reminders),
    );
  }

  /// Return reminders for a habit as a plain list (useful for immediate reads in initState)
  Future<List<HabitReminder>> getReminders(String habitId) async {
    final result = await _repo.getForHabit(habitId);
    return result.fold((e) {
      developer.log('getReminders: failed to fetch reminders: $e',
          name: 'HabitRemindersController');
      return <HabitReminder>[];
    }, (reminders) {
      return reminders;
    });
  }

  /// Delete all reminders for the given habit
  Future<void> clearForHabit(String habitId) async {
    final result = await _repo.getForHabit(habitId);

    await result.fold((e) async {
      developer.log('clearForHabit: failed to fetch reminders: $e',
          name: 'HabitRemindersController');
      // leave state untouched or set to error
      state = AsyncValue.error(e, StackTrace.current);
    }, (reminders) async {
      for (final r in reminders) {
        try {
          final delRes = await _repo.delete(r.id);
          delRes.fold(
            (delErr) => developer.log(
                'Failed to delete reminder ${r.id}: $delErr',
                name: 'HabitRemindersController'),
            (_) => developer.log('Deleted reminder ${r.id}',
                name: 'HabitRemindersController'),
          );
        } catch (ex, st) {
          developer.log('Exception deleting reminder ${r.id}: $ex',
              name: 'HabitRemindersController', error: ex, stackTrace: st);
        }
      }
      // Clear controller state after deletion (safe default)
      state = const AsyncValue.data([]);
    });
  }

  Future<void> addReminder(HabitReminder reminder) async {
    final result = await _repo.add(reminder);
    result.fold(
      (e) {
        developer.log('addReminder: failed: $e',
            name: 'HabitRemindersController');
        state = AsyncValue.error(e, StackTrace.current);
      },
      (r) => state.whenData((list) => state = AsyncValue.data([...list, r])),
    );
  }

  Future<void> updateReminder(HabitReminder reminder) async {
    final result = await _repo.update(reminder);
    result.fold(
      (e) {
        developer.log('updateReminder: failed: $e',
            name: 'HabitRemindersController');
        state = AsyncValue.error(e, StackTrace.current);
      },
      (r) => state.whenData((list) {
        final updated = [...list.where((rem) => rem.id != r.id), r];
        state = AsyncValue.data(updated);
      }),
    );
  }

  Future<void> deleteReminder(String reminderId) async {
    final result = await _repo.delete(reminderId);
    result.fold(
      (e) {
        developer.log('deleteReminder: failed: $e',
            name: 'HabitRemindersController');
        state = AsyncValue.error(e, StackTrace.current);
      },
      (_) => state.whenData(
        (list) => state =
            AsyncValue.data(list.where((r) => r.id != reminderId).toList()),
      ),
    );
  }
}
