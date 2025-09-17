// File: lib/src/features/habits/domain/usecases/get_habits_for_day.dart
import 'dart:developer';
import 'package:zentry/src/shared/domain/errors/result.dart';
import '../entities/habit_details.dart';
import '../../../../shared/domain/repos/habits_repo.dart';

class GetHabitsForDay {
  final HabitsRepo repo;
  const GetHabitsForDay(this.repo);

  Stream<Result<List<HabitDetails>>> call({
    required DateTime day,
    String? sectionId,
  }) {
    final stream = repo.watchHabitsForDay(day: day, sectionId: sectionId);

    return stream.map((result) {
      result.fold(
        (failure) =>
            log('Failed to fetch habits: $failure', name: 'GetHabitsForDay'),
        (habits) => log('Fetched ${habits.length} habits for day $day',
            name: 'GetHabitsForDay'),
      );
      return result;
    });
  }
}
