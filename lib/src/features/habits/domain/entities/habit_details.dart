import 'package:equatable/equatable.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_log.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_reminder.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
import 'package:zentry/src/shared/domain/entities/habit.dart';

/// Normalize DateTime to midnight
DateTime _atMidnight(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

class HabitDetails extends Equatable {
  final Habit habit;
  final List<HabitLog> logs;
  final List<HabitReminder> reminders;

  const HabitDetails({
    required this.habit,
    required this.logs,
    required this.reminders,
  });

  /// Factory to create HabitDetails from a Habit with empty logs/reminders
  factory HabitDetails.fromHabit(Habit habit) {
    return HabitDetails(
      habit: habit,
      logs: const [],
      reminders: const [],
    );
  }

  /// Copy with optional override
  HabitDetails copyWith({
    Habit? habit,
    List<HabitLog>? logs,
    List<HabitReminder>? reminders,
  }) {
    return HabitDetails(
      habit: habit ?? this.habit,
      logs: logs ?? this.logs,
      reminders: reminders ?? this.reminders,
    );
  }

  /// Convert HabitDetails into a HabitLog entry
  HabitLog toHabitLog({HabitStatus status = HabitStatus.completed}) {
    final logId = DateTime.now().microsecondsSinceEpoch.toString();
    return HabitLog(
      id: logId,
      habitId: habit.id,
      date: DateTime.now(),
      status: status,
    );
  }

  /// ✅ Check completion status for a specific day
  bool isCompletedOn(DateTime day) {
    final target = _atMidnight(day.toLocal());
    return logs.any((log) {
      final logDate = _atMidnight(log.date.toLocal());
      return logDate == target && log.status == HabitStatus.completed;
    });
  }

  @override
  List<Object?> get props => [habit, logs, reminders];
}
