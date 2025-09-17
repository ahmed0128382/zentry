// import 'package:equatable/equatable.dart';
// import 'package:zentry/src/features/habits/domain/entities/habit_goal.dart';
// import 'package:zentry/src/features/habits/domain/enums/habit_frequency.dart';
// import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
// import 'package:zentry/src/features/habits/domain/enums/section_type.dart';
// import 'package:zentry/src/features/habits/domain/enums/weekday.dart';
// import 'package:zentry/src/features/habits/domain/value_objects/weekday_mask.dart';

// class Habit extends Equatable {
//   final String id;
//   final String title;
//   final String? description;
//   final String? sectionId;
//   final HabitStatus status;
//   final HabitFrequency frequency;
//   final WeekdayMask? weeklyDays;
//   final int? intervalDays;
//   final HabitGoal goal;
//   final bool autoPopup;
//   final int orderInSection; // ✅ new field
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   const Habit({
//     required this.id,
//     required this.title,
//     this.description,
//     required this.sectionId,
//     required this.status,
//     required this.frequency,
//     this.weeklyDays,
//     this.intervalDays,
//     required this.goal,
//     this.autoPopup = true,
//     this.orderInSection = 0, // default value
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   Habit copyWith({
//     String? id,
//     String? title,
//     String? description,
//     String? sectionId,
//     HabitStatus? status,
//     HabitFrequency? frequency,
//     WeekdayMask? weeklyDays,
//     int? intervalDays,
//     HabitGoal? goal,
//     bool? autoPopup,
//     int? orderInSection, // ✅ add here too
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) {
//     return Habit(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       description: description ?? this.description,
//       sectionId: sectionId ?? this.sectionId,
//       status: status ?? this.status,
//       frequency: frequency ?? this.frequency,
//       weeklyDays: weeklyDays ?? this.weeklyDays,
//       intervalDays: intervalDays ?? this.intervalDays,
//       goal: goal ?? this.goal,
//       autoPopup: autoPopup ?? this.autoPopup,
//       orderInSection: orderInSection ?? this.orderInSection, // ✅
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         id,
//         title,
//         description,
//         sectionId,
//         status,
//         frequency,
//         weeklyDays,
//         intervalDays,
//         goal,
//         autoPopup,
//         orderInSection, // ✅ add here
//         createdAt,
//         updatedAt,
//       ];
// }

// extension HabitX on Habit {
//   SectionType? get sectionType {
//     switch (sectionId) {
//       case 'morning':
//         return SectionType.morning;
//       case 'afternoon':
//         return SectionType.afternoon;
//       case 'evening':
//         return SectionType.evening;
//       case 'anytime':
//         return SectionType.anytime;
//       default:
//         return null; // ✅ للأقسام المخصصة من المستخدم
//     }
//   }

//   bool get isCustomSection => sectionType == null && sectionId != null;
// }

// /// Helper to normalize a DateTime to local midnight (date-only)
// DateTime _atMidnight(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

// /// Extension on Habit to check if it’s scheduled for a given day.
// extension HabitScheduleX on Habit {
//   bool isScheduledForDay(DateTime day) {
//     final target = _atMidnight(day.toLocal());

//     // Skip non-active habits
//     if (status != HabitStatus.active) return false;

//     // Respect goal start/end dates if provided
//     if (goal.startDate != null) {
//       final start = _atMidnight(goal.startDate!.toLocal());
//       if (target.isBefore(start)) return false;
//     }
//     if (goal.endDate != null) {
//       final end = _atMidnight(goal.endDate!.toLocal());
//       if (target.isAfter(end)) return false;
//     }

//     switch (frequency) {
//       case HabitFrequency.daily:
//         return true; // every day inside goal window

//       case HabitFrequency.weekly:
//         if (weeklyDays == null) return false;
//         final weekday = Weekday.values[target.weekday - 1]; // 1=Mon..7=Sun
//         return weeklyDays!.includes(weekday);

//       case HabitFrequency.monthly:
//         final anchorDay = goal.startDate?.day ?? createdAt.toLocal().day;
//         final lastDayOfMonth = DateTime(target.year, target.month + 1, 0).day;
//         final effectiveDay =
//             (anchorDay <= lastDayOfMonth) ? anchorDay : lastDayOfMonth;
//         return target.day == effectiveDay;

//       case HabitFrequency.interval:
//         if (intervalDays == null || intervalDays! <= 0) return false;
//         final anchor = _atMidnight((goal.startDate ?? createdAt).toLocal());
//         final daysSince = target.difference(anchor).inDays;
//         if (daysSince < 0) return false;
//         return daysSince % intervalDays! == 0;
//     }
//   }
// }
// // File: lib/src/features/habits/domain/entities/habit.dart

// import 'package:equatable/equatable.dart';
// import 'package:zentry/src/core/reminders/domain/value_objects/reminder_time.dart';
// import 'package:zentry/src/features/habits/domain/entities/habit_goal.dart';
// import 'package:zentry/src/features/habits/domain/enums/habit_frequency.dart';
// import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
// import 'package:zentry/src/features/habits/domain/enums/section_type.dart';
// import 'package:zentry/src/features/habits/domain/enums/weekday.dart';
// import 'package:zentry/src/features/habits/domain/value_objects/weekday_mask.dart';

// class Habit extends Equatable {
//   final String id;
//   final String title;
//   final String? description;
//   final String? sectionId;
//   final HabitStatus status;
//   final HabitFrequency frequency;
//   final WeekdayMask? weeklyDays;
//   final int? intervalDays;
//   final HabitGoal goal;
//   final bool autoPopup;
//   final int orderInSection;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   // 🔔 Reminder integration
//   final String? reminderId; // linked reminder id
//   final ReminderTime? reminderTime; // time of reminder
//   final List<int>? reminderDays; // weekdays (1=Mon..7=Sun)

//   const Habit({
//     required this.id,
//     required this.title,
//     this.description,
//     required this.sectionId,
//     required this.status,
//     required this.frequency,
//     this.weeklyDays,
//     this.intervalDays,
//     required this.goal,
//     this.autoPopup = true,
//     this.orderInSection = 0,
//     required this.createdAt,
//     required this.updatedAt,
//     this.reminderId,
//     this.reminderTime,
//     this.reminderDays,
//   });

//   Habit copyWith({
//     String? id,
//     String? title,
//     String? description,
//     String? sectionId,
//     HabitStatus? status,
//     HabitFrequency? frequency,
//     WeekdayMask? weeklyDays,
//     int? intervalDays,
//     HabitGoal? goal,
//     bool? autoPopup,
//     int? orderInSection,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     String? reminderId,
//     ReminderTime? reminderTime,
//     List<int>? reminderDays,
//   }) {
//     return Habit(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       description: description ?? this.description,
//       sectionId: sectionId ?? this.sectionId,
//       status: status ?? this.status,
//       frequency: frequency ?? this.frequency,
//       weeklyDays: weeklyDays ?? this.weeklyDays,
//       intervalDays: intervalDays ?? this.intervalDays,
//       goal: goal ?? this.goal,
//       autoPopup: autoPopup ?? this.autoPopup,
//       orderInSection: orderInSection ?? this.orderInSection,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       reminderId: reminderId ?? this.reminderId,
//       reminderTime: reminderTime ?? this.reminderTime,
//       reminderDays: reminderDays ?? this.reminderDays,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         id,
//         title,
//         description,
//         sectionId,
//         status,
//         frequency,
//         weeklyDays,
//         intervalDays,
//         goal,
//         autoPopup,
//         orderInSection,
//         createdAt,
//         updatedAt,
//         reminderId,
//         reminderTime,
//         reminderDays,
//       ];
// }

// extension HabitX on Habit {
//   SectionType? get sectionType {
//     switch (sectionId) {
//       case 'morning':
//         return SectionType.morning;
//       case 'afternoon':
//         return SectionType.afternoon;
//       case 'evening':
//         return SectionType.evening;
//       case 'anytime':
//         return SectionType.anytime;
//       default:
//         return null; // custom user-defined section
//     }
//   }

//   bool get isCustomSection => sectionType == null && sectionId != null;
// }

// /// Helper to normalize a DateTime to local midnight (date-only)
// DateTime _atMidnight(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

// /// Extension on Habit to check if it’s scheduled for a given day.
// extension HabitScheduleX on Habit {
//   bool isScheduledForDay(DateTime day) {
//     final target = _atMidnight(day.toLocal());

//     // Skip non-active habits
//     if (status != HabitStatus.active) return false;

//     // Respect goal start/end dates if provided
//     if (goal.startDate != null) {
//       final start = _atMidnight(goal.startDate!.toLocal());
//       if (target.isBefore(start)) return false;
//     }
//     if (goal.endDate != null) {
//       final end = _atMidnight(goal.endDate!.toLocal());
//       if (target.isAfter(end)) return false;
//     }

//     switch (frequency) {
//       case HabitFrequency.daily:
//         return true;

//       case HabitFrequency.weekly:
//         if (weeklyDays == null) return false;
//         final weekday = Weekday.values[target.weekday - 1]; // 1=Mon..7=Sun
//         return weeklyDays!.includes(weekday);

//       case HabitFrequency.monthly:
//         final anchorDay = goal.startDate?.day ?? createdAt.toLocal().day;
//         final lastDayOfMonth = DateTime(target.year, target.month + 1, 0).day;
//         final effectiveDay =
//             (anchorDay <= lastDayOfMonth) ? anchorDay : lastDayOfMonth;
//         return target.day == effectiveDay;

//       case HabitFrequency.interval:
//         if (intervalDays == null || intervalDays! <= 0) return false;
//         final anchor = _atMidnight((goal.startDate ?? createdAt).toLocal());
//         final daysSince = target.difference(anchor).inDays;
//         if (daysSince < 0) return false;
//         return daysSince % intervalDays! == 0;
//     }
//   }
// }
// File: lib/src/features/habits/domain/entities/habit.dart

import 'package:equatable/equatable.dart';
import 'package:zentry/src/core/reminders/domain/entities/reminder.dart'
    as core_reminder;
import 'package:zentry/src/core/reminders/domain/entities/periodic_types.dart';
import 'package:zentry/src/core/reminders/domain/value_objects/reminder_time.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_goal.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_frequency.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
import 'package:zentry/src/features/habits/domain/enums/section_type.dart';
import 'package:zentry/src/features/habits/domain/enums/weekday.dart';
import 'package:zentry/src/features/habits/domain/value_objects/weekday_mask.dart';

class Habit extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String? sectionId;
  final HabitStatus status;
  final HabitFrequency frequency;
  final WeekdayMask? weeklyDays;
  final int? intervalDays;
  final HabitGoal goal;
  final bool autoPopup;
  final int orderInSection;
  final DateTime createdAt;
  final DateTime updatedAt;

  // 🔔 Reminder integration (kept optional to avoid breaking existing usage)
  /// An id returned by the Reminder system (optional).
  final String? reminderId;

  /// Local/time-only representation of the time for the habit's reminder (optional).
  final ReminderTime? reminderTime;

  /// Weekday list for the habit's reminder (1 = Monday ... 7 = Sunday). Optional.
  final List<int>? reminderDays;

  const Habit({
    required this.id,
    required this.title,
    this.description,
    required this.sectionId,
    required this.status,
    required this.frequency,
    this.weeklyDays,
    this.intervalDays,
    required this.goal,
    this.autoPopup = true,
    this.orderInSection = 0,
    required this.createdAt,
    required this.updatedAt,
    this.reminderId,
    this.reminderTime,
    this.reminderDays,
  });

  Habit copyWith({
    String? id,
    String? title,
    String? description,
    String? sectionId,
    HabitStatus? status,
    HabitFrequency? frequency,
    WeekdayMask? weeklyDays,
    int? intervalDays,
    HabitGoal? goal,
    bool? autoPopup,
    int? orderInSection,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? reminderId,
    ReminderTime? reminderTime,
    List<int>? reminderDays,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      sectionId: sectionId ?? this.sectionId,
      status: status ?? this.status,
      frequency: frequency ?? this.frequency,
      weeklyDays: weeklyDays ?? this.weeklyDays,
      intervalDays: intervalDays ?? this.intervalDays,
      goal: goal ?? this.goal,
      autoPopup: autoPopup ?? this.autoPopup,
      orderInSection: orderInSection ?? this.orderInSection,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      reminderId: reminderId ?? this.reminderId,
      reminderTime: reminderTime ?? this.reminderTime,
      reminderDays: reminderDays ?? this.reminderDays,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        sectionId,
        status,
        frequency,
        weeklyDays,
        intervalDays,
        goal,
        autoPopup,
        orderInSection,
        createdAt,
        updatedAt,
        reminderId,
        reminderTime,
        reminderDays,
      ];
}

extension HabitX on Habit {
  SectionType? get sectionType {
    switch (sectionId) {
      case 'morning':
        return SectionType.morning;
      case 'afternoon':
        return SectionType.afternoon;
      case 'evening':
        return SectionType.evening;
      case 'anytime':
        return SectionType.anytime;
      default:
        return null; // custom user-defined section
    }
  }

  bool get isCustomSection => sectionType == null && sectionId != null;
}

/// Helper to normalize a DateTime to local midnight (date-only)
DateTime _atMidnight(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

/// Extension on Habit to check if it’s scheduled for a given day.
extension HabitScheduleX on Habit {
  bool isScheduledForDay(DateTime day) {
    final target = _atMidnight(day.toLocal());

    // Skip non-active habits
    if (status != HabitStatus.active) return false;

    // Respect goal start/end dates if provided
    if (goal.startDate != null) {
      final start = _atMidnight(goal.startDate!.toLocal());
      if (target.isBefore(start)) return false;
    }
    if (goal.endDate != null) {
      final end = _atMidnight(goal.endDate!.toLocal());
      if (target.isAfter(end)) return false;
    }

    switch (frequency) {
      case HabitFrequency.daily:
        return true;

      case HabitFrequency.weekly:
        if (weeklyDays == null) return false;
        final weekday = Weekday.values[target.weekday - 1]; // 1=Mon..7=Sun
        return weeklyDays!.includes(weekday);

      case HabitFrequency.monthly:
        final anchorDay = goal.startDate?.day ?? createdAt.toLocal().day;
        final lastDayOfMonth = DateTime(target.year, target.month + 1, 0).day;
        final effectiveDay =
            (anchorDay <= lastDayOfMonth) ? anchorDay : lastDayOfMonth;
        return target.day == effectiveDay;

      case HabitFrequency.interval:
        if (intervalDays == null || intervalDays! <= 0) return false;
        final anchor = _atMidnight((goal.startDate ?? createdAt).toLocal());
        final daysSince = target.difference(anchor).inDays;
        if (daysSince < 0) return false;
        return daysSince % intervalDays! == 0;
    }
  }
}

/// -----------------------------
/// Reminder helpers (safe & optional)
/// -----------------------------
extension HabitReminderHelpers on Habit {
  /// Whether this habit has reminder-related settings (time) set.
  bool get hasReminder => reminderTime != null;

  /// Convert this Habit into a core `Reminder` object.
  ///
  /// - Throws `StateError` if this habit has no `reminderTime`.
  /// - Uses `reminderId` if present as the reminder id; otherwise generates one
  ///   using the habit id + time seconds-since-midnight.
  /// - `ownerType` is set to `'habit'`.
  core_reminder.Reminder toCoreReminder({
    String? idOverride,
    String? titleOverride,
    String? bodyOverride,
    PeriodicType? periodicTypeOverride,
  }) {
    if (!hasReminder || reminderTime == null) {
      throw StateError(
          'Habit has no reminderTime; cannot convert to Reminder.');
    }

    final idToUse = idOverride ??
        reminderId ??
        '${id}_${reminderTime!.totalSecondsSinceMidnight}';

    final List<int> weekdays = reminderDays ?? [];

    return core_reminder.Reminder(
      id: idToUse,
      ownerId: id,
      ownerType: 'habit',
      time: reminderTime!,
      enabled: true,
      weekdays: weekdays,
      title: titleOverride ?? title,
      body: bodyOverride,
      metadata: {
        'habitId': id,
        'habitTitle': title,
      },
      periodicType: periodicTypeOverride,
    );
  }
}
