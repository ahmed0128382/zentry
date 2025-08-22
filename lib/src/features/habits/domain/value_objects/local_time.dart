import 'package:equatable/equatable.dart';

/// Simple domain-level time-of-day (avoids Flutter dependency in domain).
class LocalTime extends Equatable {
  final int hour; // 0..23
  final int minute; // 0..59

  const LocalTime(this.hour, this.minute)
      : assert(hour >= 0 && hour < 24),
        assert(minute >= 0 && minute < 60);

  factory LocalTime.fromString(String hhmm) {
    final parts = hhmm.split(':');
    return LocalTime(int.parse(parts[0]), int.parse(parts[1]));
  }

  String get hhmm =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  int get minutesSinceMidnight => hour * 60 + minute;

  @override
  List<Object?> get props => [hour, minute];
}
