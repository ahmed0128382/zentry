import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/infrastucture/drift/app_database.dart';

/// Singleton AppDatabase instance
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
