import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_database_provider.dart';
import 'package:zentry/src/features/appearance/domain/repos/appearance_repo.dart';
import 'package:zentry/src/features/appearance/infrastructure/repo/appearance_repo_impl.dart';

final appearanceRepoProvider = Provider<AppearanceRepo>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return AppearanceRepoImpl(db);
});
