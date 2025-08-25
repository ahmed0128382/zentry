// File: src/features/sections/infrastructure/repositories/sections_repo_impl.dart

import 'dart:developer';

import 'package:zentry/src/core/infrastucture/drift/app_database.dart';
import 'package:zentry/src/features/habits/domain/entities/section.dart';
import 'package:zentry/src/features/habits/domain/repos/sections_repo.dart';
import 'package:zentry/src/features/habits/infrastructure/mappers/habit_section_mapper.dart';
import 'package:zentry/src/shared/infrastructure/utils/guard.dart';

class SectionsRepoImpl implements SectionsRepo {
  final AppDatabase _db;

  SectionsRepoImpl(this._db);

  @override
  Future<Result<List<Section>>> getAll() async {
    return guard(() async {
      final rows = await _db.getAllSections();
      log('Repo: fetched sections -> $rows');
      return rows.map(sectionFromRow).toList();
    });
  }

  @override
  Future<Result<Section>> getById(String id) async {
    return guard(() async {
      final row = await _db.getSectionById(id);
      if (row == null) throw Exception('Section not found');
      return sectionFromRow(row);
    });
  }

  @override
  Future<Result<Section>> create(Section section) async {
    return guard(() async {
      final row = await _db.insertSection(sectionToCompanion(section));
      return sectionFromRow(row);
    });
  }

  @override
  Future<Result<Section>> update(Section section) async {
    return guard(() async {
      final row = await _db.updateSection(sectionToCompanion(section));
      if (row == null) throw Exception('Section not found');
      return sectionFromRow(row);
    });
  }

  @override
  Future<Result<void>> delete(String id) async {
    return guard(() async {
      await _db.deleteSection(id);
    });
  }

  @override
  Future<Result<void>> reorder(List<String> orderedSectionIds) async {
    return guard(() async {
      await _db.reorderSections(orderedSectionIds);
    });
  }
}
