// Repository provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_database_provider.dart';
import 'package:zentry/src/features/habits/infrastructure/repos/habits_repo_impl.dart';
import 'package:zentry/src/shared/domain/repos/habits_repo.dart';

final habitRepositoryProvider = Provider<HabitsRepo>((ref) {
  return HabitsRepoImpl(
    ref.read(appDatabaseProvider),
  );
});
