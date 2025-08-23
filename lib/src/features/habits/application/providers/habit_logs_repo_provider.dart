import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_database_provider.dart';
import 'package:zentry/src/features/habits/domain/repos/habit_logs_repo.dart';
import 'package:zentry/src/features/habits/infrastructure/repos/habit_logs_repo_impl.dart';

final habitLogsRepoProvider = Provider<HabitLogsRepo>((ref) {
  return HabitLogsRepoImpl(
    ref.read(appDatabaseProvider),
  );
});
