import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/application/providers/habit_repo_provider.dart';
import '../../domain/entities/section_with_habits.dart';
import '../../../../shared/domain/errors/result.dart';

final sectionsWithHabitsProvider = StreamProvider.autoDispose
    .family<Result<List<SectionWithHabits>>, DateTime>((ref, day) {
  final repo = ref.watch(habitRepositoryProvider);
  return repo.watchSectionsWithHabitsForDay(day);
});
