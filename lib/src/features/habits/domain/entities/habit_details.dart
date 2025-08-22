// lib/src/features/habits/domain/entities/habit_details.dart
import 'package:equatable/equatable.dart';

import 'habit.dart';
import 'habit_log.dart';

/// Aggregate for read-models where you need a habit plus today's state/logs.
/// Keep this lean so it stays UI-friendly.
class HabitDetails extends Equatable {
  final Habit habit;

  /// Logs relevant to the current view scope (e.g., for a specific day)
  final List<HabitLog> logs;

  /// Derived flags that the presentation layer often needs quickly.
  final bool isCompletedForDay;

  const HabitDetails({
    required this.habit,
    required this.logs,
    required this.isCompletedForDay,
  });

  HabitDetails copyWith({
    Habit? habit,
    List<HabitLog>? logs,
    bool? isCompletedForDay,
  }) {
    return HabitDetails(
      habit: habit ?? this.habit,
      logs: logs ?? this.logs,
      isCompletedForDay: isCompletedForDay ?? this.isCompletedForDay,
    );
  }

  @override
  List<Object?> get props => [habit, logs, isCompletedForDay];
}
