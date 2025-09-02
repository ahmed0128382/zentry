import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';

abstract class RemindersState {}

class RemindersInitial extends RemindersState {}

class RemindersLoading extends RemindersState {}

class RemindersLoaded extends RemindersState {
  final List<Reminder> reminders;
  RemindersLoaded(this.reminders);
}

class RemindersError extends RemindersState {
  final String message;
  RemindersError(this.message);
}
