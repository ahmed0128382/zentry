import 'package:dartz/dartz.dart';
import '../repos/habits_repo.dart';

class ReorderHabitsWithinSection {
  final HabitsRepo repo;
  const ReorderHabitsWithinSection(this.repo);

  Future<Either<Exception, void>> call({
    required String sectionId,
    required List<String> orderedHabitIds,
  }) {
    return repo.reorderWithinSection(
      sectionId: sectionId,
      orderedHabitIds: orderedHabitIds,
    );
  }
}
