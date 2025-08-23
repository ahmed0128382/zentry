import 'package:equatable/equatable.dart';

import '../../../../shared/domain/entities/habit.dart';
import 'habit_log.dart';
import 'habit_reminder.dart'; // <- import your HabitReminder entity

/// Aggregate for read-models where you need a habit plus today's state/logs.
/// Keep this lean so it stays UI-friendly.
class HabitDetails extends Equatable {
  final Habit habit;

  /// Logs relevant to the current view scope (e.g., for a specific day)
  final List<HabitLog> logs;

  /// Habit reminders
  final List<HabitReminder> reminders;

  /// Derived flags that the presentation layer often needs quickly.
  final bool isCompletedForDay;

  const HabitDetails({
    required this.habit,
    required this.logs,
    required this.reminders, // <- add this
    required this.isCompletedForDay,
  });

  HabitDetails copyWith({
    Habit? habit,
    List<HabitLog>? logs,
    List<HabitReminder>? reminders, // <- add this
    bool? isCompletedForDay,
  }) {
    return HabitDetails(
      habit: habit ?? this.habit,
      logs: logs ?? this.logs,
      reminders: reminders ?? this.reminders, // <- add this
      isCompletedForDay: isCompletedForDay ?? this.isCompletedForDay,
    );
  }

  @override
  List<Object?> get props =>
      [habit, logs, reminders, isCompletedForDay]; // <- add reminders
}
