// File: src/features/sections/domain/repos/sections_repo.dart

import 'package:zentry/src/shared/infrastructure/utils/guard.dart';
import '../entities/section.dart';

abstract class SectionsRepo {
  Future<Result<List<Section>>> getAll();
  Future<Result<Section>> getById(String id);
  Future<Result<Section>> create(Section section);
  Future<Result<Section>> update(Section section);
  Future<Result<void>> delete(String id);
  Future<Result<void>> reorder(List<String> orderedSectionIds);
}
