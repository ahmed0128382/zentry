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

  /// Creates a copy of this HabitReminder with optional new values
  HabitReminder copyWith({
    String? id,
    String? habitId,
    int? minutesSinceMidnight,
    bool? enabled,
  }) {
    return HabitReminder(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      minutesSinceMidnight: minutesSinceMidnight ?? this.minutesSinceMidnight,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  List<Object?> get props => [id, habitId, minutesSinceMidnight, enabled];
}
