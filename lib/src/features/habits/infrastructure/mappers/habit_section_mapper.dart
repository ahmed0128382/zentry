// File: src/features/habits/infrastructure/mappers/section_mapper.dart

import 'package:drift/drift.dart';
import 'package:zentry/src/core/infrastucture/drift/app_database.dart';
import '../../domain/entities/section.dart';
import '../../domain/enums/section_type.dart';

// --- Section ---

Section sectionFromRow(SectionRow row) {
  return Section(
    id: row.id,
    type: SectionType.values.firstWhere((e) => e.name == row.type),
    orderIndex: row.orderIndex,
  );
}

SectionsTableCompanion sectionToCompanion(Section section) {
  return SectionsTableCompanion(
    id: Value(section.id),
    type: Value(section.type.name),
    orderIndex: Value(section.orderIndex),
  );
}
