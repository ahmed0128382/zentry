enum Weekday { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

extension WeekdayX on Weekday {
  int get bit => 1 << index; // for bitmask storage
}
