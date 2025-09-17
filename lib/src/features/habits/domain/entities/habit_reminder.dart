// // File: src/features/habits/domain/entities/habit_reminder.dart
// import 'package:equatable/equatable.dart';

// class HabitReminder extends Equatable {
//   final String id; // UUID
//   final String habitId; // FK -> Habit
//   final int minutesSinceMidnight; // 0..1439
//   final bool enabled;

//   const HabitReminder({
//     required this.id,
//     required this.habitId,
//     required this.minutesSinceMidnight,
//     required this.enabled,
//   });

//   /// Creates a copy of this HabitReminder with optional new values
//   HabitReminder copyWith({
//     String? id,
//     String? habitId,
//     int? minutesSinceMidnight,
//     bool? enabled,
//   }) {
//     return HabitReminder(
//       id: id ?? this.id,
//       habitId: habitId ?? this.habitId,
//       minutesSinceMidnight: minutesSinceMidnight ?? this.minutesSinceMidnight,
//       enabled: enabled ?? this.enabled,
//     );
//   }

//   @override
//   List<Object?> get props => [id, habitId, minutesSinceMidnight, enabled];
// }
// File: src/features/habits/domain/entities/habit_reminder.dart

import 'package:equatable/equatable.dart';
import 'package:zentry/src/core/reminders/domain/entities/reminder.dart'
    as core_reminder;
import 'package:zentry/src/core/reminders/domain/entities/periodic_types.dart';
import 'package:zentry/src/core/reminders/domain/value_objects/reminder_time.dart';

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

  /// Convert this feature-level HabitReminder into a core Reminder object.
  ///
  /// - `idOverride` overrides the reminder id (if you want a different id).
  /// - `ownerIdOverride` overrides the ownerId (defaults to this.habitId).
  /// - `titleOverride` / `bodyOverride` let you set notification title/body.
  /// - `periodicTypeOverride` can be used to set a periodic type if needed.
  core_reminder.Reminder toCoreReminder({
    String? idOverride,
    String? ownerIdOverride,
    String? titleOverride,
    String? bodyOverride,
    PeriodicType? periodicTypeOverride,
  }) {
    final hh = minutesSinceMidnight ~/ 60;
    final mm = minutesSinceMidnight % 60;

    // Create a ReminderTime from hours/minutes. (ReminderTime has hour/minute fields.)
    final time = ReminderTime(hh, mm);

    final ownerId = ownerIdOverride ?? habitId;
    final idToUse = idOverride ?? id;

    return core_reminder.Reminder(
      id: idToUse,
      ownerId: ownerId,
      ownerType: 'habit',
      time: time,
      enabled: enabled,
      weekdays: const [], // habit-level reminder entries are daily by default
      title: titleOverride,
      body: bodyOverride,
      metadata: {
        'habitReminderId': id,
        'habitId': ownerId,
      },
      periodicType: periodicTypeOverride,
    );
  }

  @override
  List<Object?> get props => [id, habitId, minutesSinceMidnight, enabled];
}
