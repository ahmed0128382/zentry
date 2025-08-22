import 'package:equatable/equatable.dart';
import '../enums/weekday.dart';

class WeekdayMask extends Equatable {
  final int bits; // 7-bit mask, bit0=Mon .. bit6=Sun

  const WeekdayMask(this.bits);

  const WeekdayMask.none() : bits = 0;

  factory WeekdayMask.fromDays(Iterable<Weekday> days) {
    var mask = 0;
    for (final d in days) mask |= d.bit;
    return WeekdayMask(mask);
  }

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
