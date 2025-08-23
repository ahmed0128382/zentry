// File: src/features/habits/infrastructure/providers/habit_reminders_repo_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_database_provider.dart';
import 'package:zentry/src/features/habits/infrastructure/repos/habit_reminders_repo_impl.dart';
import '../../domain/repos/habit_reminders_repo.dart';
// your implementation

final habitRemindersRepoProvider = Provider<HabitRemindersRepo>((ref) {
  return HabitRemindersRepoImpl(
    ref.read(appDatabaseProvider),
  ); // replace with your real impl
});
