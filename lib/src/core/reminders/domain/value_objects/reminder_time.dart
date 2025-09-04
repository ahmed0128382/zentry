// File: lib/src/core/reminders/domain/value_objects/reminder_time.dart
/// Value object representing a time of day as minutes since midnight.
/// Kept free of Flutter imports so it can live in the domain layer.
class ReminderTime {
  /// Minutes since midnight (0..1439)
  final int minutesSinceMidnight;

  /// Create from minutes; validates range.
  ReminderTime(this.minutesSinceMidnight)
      : assert(minutesSinceMidnight >= 0 && minutesSinceMidnight < 24 * 60,
            'minutesSinceMidnight must be in range [0, 1439]');

  /// Create from hour (0..23) and minute (0..59)
  factory ReminderTime.fromHMS(int hour, int minute) {
    assert(hour >= 0 && hour < 24, 'hour must be in range 0..23');
    assert(minute >= 0 && minute < 60, 'minute must be in range 0..59');
    return ReminderTime(hour * 60 + minute);
  }
  factory ReminderTime.fromDateTime(DateTime dt) {
    return ReminderTime.fromHMS(dt.hour, dt.minute);
  }

  /// Parse from string "HH:mm" (24h). Throws FormatException if invalid.
  factory ReminderTime.parse(String hhmm) {
    final parts = hhmm.split(':');
    if (parts.length != 2) {
      throw FormatException('Invalid time format, expected "HH:mm"');
    }
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    if (h == null || m == null) {
      throw FormatException('Invalid hour/minute parts');
    }
    return ReminderTime.fromHMS(h, m);
  }

  /// Hour component (0..23)
  int get hour => minutesSinceMidnight ~/ 60;

  /// Minute component (0..59)
  int get minute => minutesSinceMidnight % 60;

  /// Convert to a DateTime on given [date] (local).
  /// Result uses the same date's year/month/day and this time's hour/minute.
  DateTime toDateTimeOn(DateTime date) {
    final local = DateTime(
      date.year,
      date.month,
      date.day,
      hour,
      minute,
    );
    return local;
  }

  /// Returns the next occurrence >= [from] (local) of this time on the same day
  /// or the following day when the time has already passed.
  DateTime nextOccurrenceFrom(DateTime from) {
    final candidate = toDateTimeOn(from);
    if (!candidate.isBefore(from)) {
      return candidate;
    }
    return candidate.add(const Duration(days: 1));
  }

  /// Returns the next occurrence >= [from] (local) of this time on the specified weekday.
  ///
  /// [weekday] follows Dart DateTime convention: 1 = Monday, ... 7 = Sunday.
  /// If [from]'s weekday matches and today's time is >= [from], returns today at this time.
  /// Otherwise jumps forward until the next matching weekday.
  DateTime nextOccurrenceOnWeekdayFrom(int weekday, DateTime from) {
    assert(weekday >= DateTime.monday && weekday <= DateTime.sunday,
        'weekday must be between 1 and 7');

    // Start candidate at `from`'s date with this time
    var candidate = toDateTimeOn(from);

    // If same weekday:
    if (candidate.weekday == weekday) {
      if (!candidate.isBefore(from)) {
        return candidate;
      }
      // today matched but time passed -> schedule next week
      candidate = candidate.add(const Duration(days: 7));
      return candidate;
    }

    // Find days until next target weekday
    int daysToAdd = (weekday - candidate.weekday) % 7;
    if (daysToAdd <= 0) daysToAdd += 7;
    return candidate.add(Duration(days: daysToAdd));
  }

  /// Simple formatting "HH:mm" with leading zeros.
  @override
  String toString() {
    final hh = hour.toString().padLeft(2, '0');
    final mm = minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  Map<String, dynamic> toJson() =>
      {'minutesSinceMidnight': minutesSinceMidnight};

  factory ReminderTime.fromJson(Map<String, dynamic> json) =>
      ReminderTime(json['minutesSinceMidnight'] as int);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderTime &&
          runtimeType == other.runtimeType &&
          minutesSinceMidnight == other.minutesSinceMidnight;

  @override
  int get hashCode => minutesSinceMidnight.hashCode;
}
