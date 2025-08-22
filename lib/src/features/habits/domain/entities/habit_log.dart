import 'package:equatable/equatable.dart';
import '../enums/habit_status.dart';

class HabitLog extends Equatable {
  final String id;
  final String habitId;
  final DateTime date; // log date (UTC midnight usually)
  final HabitStatus status;

  const HabitLog({
    required this.id,
    required this.habitId,
    required this.date,
    required this.status,
  });

  HabitLog copyWith({
    String? id,
    String? habitId,
    DateTime? date,
    HabitStatus? status,
  }) {
    return HabitLog(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, habitId, date, status];
}
