// File: src/features/sections/infrastructure/providers/sections_repo_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_database_provider.dart';
import 'package:zentry/src/features/habits/infrastructure/repos/section_repo_impl.dart';
import '../../domain/repos/sections_repo.dart';

final sectionsRepoProvider = Provider<SectionsRepo>((ref) {
  return SectionsRepoImpl(
    ref.read(appDatabaseProvider),
  ); // replace with your real impl
});
