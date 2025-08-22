// File: src/features/habits/domain/entities/habit_reminder.dart
import 'package:equatable/equatable.dart';

class HabitReminder extends Equatable {
  final String id; // UUID
  final String habitId; // FK -> Habit
  final int minutesSinceMidnight; // 0..1439
  final bool enabled;

  const HabitReminder({
    required this.id,
    required this.habitId,
    required this.minutesSinceMidnight,
    required this.enabled,
  });

  @override
  List<Object?> get props => [id, habitId, minutesSinceMidnight, enabled];
}
