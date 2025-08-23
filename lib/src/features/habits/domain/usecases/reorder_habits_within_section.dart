import 'package:zentry/src/shared/infrastructure/utils/guard.dart';
import '../../../../shared/domain/repos/habits_repo.dart';

class ReorderHabitsWithinSection {
  final HabitsRepo repo;
  const ReorderHabitsWithinSection(this.repo);

  Future<Result<void>> call({
    required String sectionId,
    required List<String> orderedHabitIds,
  }) {
    return repo.reorderWithinSection(
      sectionId: sectionId,
      orderedHabitIds: orderedHabitIds,
    );
  }
}
