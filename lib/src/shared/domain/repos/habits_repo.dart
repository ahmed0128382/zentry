import 'package:zentry/src/shared/domain/errors/result.dart';

import '../entities/habit.dart';
import '../../../features/habits/domain/entities/habit_details.dart';

abstract class HabitsRepo {
  Future<Result<Habit>> create(Habit habit);
  Future<Result<Habit>> update(Habit habit);
  Future<Result<void>> delete(String habitId);

  Future<Result<Habit>> getById(String id);

  /// Watch hydrated models for a specific day and section
  Stream<Result<List<HabitDetails>>> watchHabitsForDay({
    required DateTime day,
    String? sectionId,
  });

  /// Drag & drop between sections / reorder
  Future<Result<void>> moveToSection({
    required String habitId,
    required String newSectionId,
    required int newOrderIndex,
  });

  Future<Result<void>> reorderWithinSection({
    required String sectionId,
    required List<String> orderedHabitIds,
  });
}
