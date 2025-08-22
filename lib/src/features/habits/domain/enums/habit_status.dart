enum HabitStatus {
  active,
  archived,
  completed,
}

extension HabitStatusX on HabitStatus {
  bool get isCompleted => this == HabitStatus.completed;
}
