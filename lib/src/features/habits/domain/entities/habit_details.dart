// File: src/features/habits/domain/entities/habit_details.dart

import 'package:equatable/equatable.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';

import '../../../../shared/domain/entities/habit.dart';
import 'habit_log.dart';
import 'habit_reminder.dart';

class HabitDetails extends Equatable {
  final Habit habit;
  final List<HabitLog> logs;
  final List<HabitReminder> reminders;
  final bool isCompletedForDay;

  const HabitDetails({
    required this.habit,
    required this.logs,
    required this.reminders,
    required this.isCompletedForDay,
  });

  HabitDetails copyWith({
    Habit? habit,
    List<HabitLog>? logs,
    List<HabitReminder>? reminders,
    bool? isCompletedForDay,
  }) {
    return HabitDetails(
      habit: habit ?? this.habit,
      logs: logs ?? this.logs,
      reminders: reminders ?? this.reminders,
      isCompletedForDay: isCompletedForDay ?? this.isCompletedForDay,
    );
  }

  /// Convert HabitDetails to a HabitLog for marking completion
  HabitLog toHabitLog({HabitStatus status = HabitStatus.completed}) {
    final logId =
        DateTime.now().microsecondsSinceEpoch.toString(); // simple unique ID
    return HabitLog(
      id: logId,
      habitId: habit.id,
      date: DateTime.now(),
      status: status,
    );
  }

  @override
  List<Object?> get props => [habit, logs, reminders, isCompletedForDay];
}
