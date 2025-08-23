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
    return repo.watchHabitsForDay(
      day: day,
      sectionId: sectionId,
    );
  }
}
