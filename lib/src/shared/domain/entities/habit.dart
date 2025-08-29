import 'package:equatable/equatable.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_goal.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_frequency.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
import 'package:zentry/src/features/habits/domain/enums/section_type.dart';
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
  final int orderInSection; // ✅ new field
  final DateTime createdAt;
  final DateTime updatedAt;

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
    this.orderInSection = 0, // default value
    required this.createdAt,
    required this.updatedAt,
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
    int? orderInSection, // ✅ add here too
    DateTime? createdAt,
    DateTime? updatedAt,
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
      orderInSection: orderInSection ?? this.orderInSection, // ✅
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
        orderInSection, // ✅ add here
        createdAt,
        updatedAt,
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
        return null; // ✅ للأقسام المخصصة من المستخدم
    }
  }

  bool get isCustomSection => sectionType == null && sectionId != null;
}
