import 'package:dartz/dartz.dart';
import '../entities/habit_details.dart';
import '../repos/habits_repo.dart';

class GetHabitsForDay {
  final HabitsRepo repo;
  const GetHabitsForDay(this.repo);

  Stream<Either<Exception, List<HabitDetails>>> call({
    required DateTime day,
    String? sectionId,
  }) {
    return repo.watchHabitsForDay(
      day: day,
      sectionId: sectionId,
    );
  }
}
