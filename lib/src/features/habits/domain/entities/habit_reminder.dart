import 'package:equatable/equatable.dart';
import '../value_objects/local_time.dart';

class HabitReminder extends Equatable {
  final String id; // UUID
  final String habitId; // FK -> Habit
  final LocalTime time;
  final bool enabled;

  const HabitReminder({
    required this.id,
    required this.habitId,
    required this.time,
    required this.enabled,
  });

  @override
  List<Object?> get props => [id, habitId, time, enabled];
}
