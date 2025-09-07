/// Value object representing a time of day as hours, minutes, and seconds.
/// Kept free of Flutter imports so it can live in the domain layer.
class ReminderTime {
  final int hour;
  final int minute;
  final int second;

  /// Total seconds since midnight
  int get totalSecondsSinceMidnight => hour * 3600 + minute * 60 + second;

  /// Create from H:M:S with validation
  ReminderTime(this.hour, this.minute, [this.second = 0])
      : assert(hour >= 0 && hour < 24, 'hour must be in range 0..23'),
        assert(minute >= 0 && minute < 60, 'minute must be in range 0..59'),
        assert(second >= 0 && second < 60, 'second must be in range 0..59');

  /// Factory from hour, minute, optional second
  factory ReminderTime.fromHMS(int hour, int minute, [int second = 0]) {
    return ReminderTime(hour, minute, second);
  }

  factory ReminderTime.fromDateTime(DateTime dt) {
    return ReminderTime(dt.hour, dt.minute, dt.second);
  }

  /// Parse from string "HH:mm:ss" or "HH:mm"
  factory ReminderTime.parse(String hhmmss) {
    final parts = hhmmss.split(':');
    if (parts.length < 2 || parts.length > 3) {
      throw FormatException(
          'Invalid time format, expected "HH:mm" or "HH:mm:ss"');
    }
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    final s = parts.length == 3 ? int.tryParse(parts[2]) : 0;
    if (h == null || m == null || s == null) {
      throw FormatException('Invalid hour/minute/second parts');
    }
    return ReminderTime.fromHMS(h, m, s);
  }

  /// Convert to DateTime on given date (local)
  DateTime toDateTimeOn(DateTime date) {
    return DateTime(date.year, date.month, date.day, hour, minute, second);
  }

  /// Convert to DateTime for scheduling notifications
  /// Ensures it's in the future (next day if necessary)
  DateTime toNextScheduledDateTime() {
    final now = DateTime.now();
    final candidate = toDateTimeOn(now);
    if (!candidate.isBefore(now)) {
      return candidate;
    } else {
      return candidate.add(const Duration(days: 1));
    }
  }

  /// Next occurrence from [from] (local)
  DateTime nextOccurrenceFrom(DateTime from) {
    final candidate = toDateTimeOn(from);
    if (!candidate.isBefore(from)) return candidate;
    return candidate.add(const Duration(days: 1));
  }

  @override
  String toString() {
    final hh = hour.toString().padLeft(2, '0');
    final mm = minute.toString().padLeft(2, '0');
    final ss = second.toString().padLeft(2, '0');
    return '$hh:$mm:$ss';
  }

  Map<String, dynamic> toJson() => {
        'hour': hour,
        'minute': minute,
        'second': second,
      };

  factory ReminderTime.fromJson(Map<String, dynamic> json) => ReminderTime(
        json['hour'] as int,
        json['minute'] as int,
        json['second'] as int? ?? 0,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderTime &&
          runtimeType == other.runtimeType &&
          hour == other.hour &&
          minute == other.minute &&
          second == other.second;

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode ^ second.hashCode;
}
