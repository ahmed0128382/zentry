import 'package:dartz/dartz.dart';
import '../entities/habit.dart';
import '../../../features/habits/domain/entities/habit_details.dart';

abstract class HabitsRepo {
  Future<Either<Exception, Habit>> create(Habit habit);
  Future<Either<Exception, Habit>> update(Habit habit);
  Future<Either<Exception, void>> delete(String habitId);

  Future<Either<Exception, Habit>> getById(String id);

  /// Watch hydrated models for a specific day and section
  Stream<Either<Exception, List<HabitDetails>>> watchHabitsForDay({
    required DateTime day,
    String? sectionId,
  });

  /// Drag & drop between sections / reorder
  Future<Either<Exception, void>> moveToSection({
    required String habitId,
    required String newSectionId,
    required int newOrderIndex,
  });

  Future<Either<Exception, void>> reorderWithinSection({
    required String sectionId,
    required List<String> orderedHabitIds,
  });
}
