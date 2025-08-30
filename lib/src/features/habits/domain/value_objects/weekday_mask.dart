// lib/src/shared/domain/value_objects/weekday_mask.dart
import 'package:equatable/equatable.dart';
import '../enums/weekday.dart';

// class WeekdayMask extends Equatable {
//   final int bits; // 7-bit mask, bit0=Mon .. bit6=Sun

//   const WeekdayMask(this.bits);

//   const WeekdayMask.none() : bits = 0;

//   /// Creates WeekdayMask from a set of Weekdays
//   factory WeekdayMask.fromDays(Iterable<Weekday> days) {
//     var mask = 0;
//     for (final d in days) mask |= d.bit;
//     return WeekdayMask(mask);
//   }

//   /// Creates WeekdayMask from an int mask (0..127)
//   factory WeekdayMask.fromInt(int mask) => WeekdayMask(mask);

//   /// Returns the int representation of this mask
//   int toInt() => bits;

//   bool includes(Weekday d) => (bits & d.bit) != 0;

//   Set<Weekday> get days {
//     final result = <Weekday>{};
//     for (final d in Weekday.values) {
//       if (includes(d)) result.add(d);
//     }
//     return result;
//   }

//   @override
//   List<Object?> get props => [bits];
// }

/// Value object for masking weekdays
class WeekdayMask extends Equatable {
  final int bits; // 7-bit mask, bit0=Mon .. bit6=Sun

  const WeekdayMask(this.bits);

  const WeekdayMask.none() : bits = 0;

  /// Creates WeekdayMask from a set of Weekdays
  factory WeekdayMask.fromDays(Iterable<Weekday> days) {
    var mask = 0;
    for (final d in days) {
      mask |= d.bit;
    }
    return WeekdayMask(mask);
  }

  /// Creates WeekdayMask from an int mask (0..127)
  factory WeekdayMask.fromInt(int mask) => WeekdayMask(mask);

  /// Returns the int representation of this mask
  int toInt() => bits;

  bool includes(Weekday d) => (bits & d.bit) != 0;

  Set<Weekday> get days {
    final result = <Weekday>{};
    for (final d in Weekday.values) {
      if (includes(d)) result.add(d);
    }
    return result;
  }

  @override
  List<Object?> get props => [bits];
}
