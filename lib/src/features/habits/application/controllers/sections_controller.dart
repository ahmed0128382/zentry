// File: src/features/sections/application/controllers/sections_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/domain/entities/section.dart';
import 'package:zentry/src/features/habits/domain/repos/sections_repo.dart';

class SectionsController extends StateNotifier<AsyncValue<List<Section>>> {
  final SectionsRepo _repo;

  SectionsController(this._repo) : super(const AsyncValue.loading());

  Future<void> loadSections() async {
    state = const AsyncValue.loading();
    final result = await _repo.getAll();
    state = result.fold(
      (e) => AsyncValue.error(e, StackTrace.current),
      (sections) => AsyncValue.data(sections),
    );
  }

  Future<void> createSection(Section section) async {
    final result = await _repo.create(section);
    result.fold(
      (e) => state = AsyncValue.error(e, StackTrace.current),
      (s) => state.whenData((list) => state = AsyncValue.data([...list, s])),
    );
  }

  Future<void> updateSection(Section section) async {
    final result = await _repo.update(section);
    result.fold(
      (e) => state = AsyncValue.error(e, StackTrace.current),
      (s) => state.whenData((list) {
        final updated = [...list.where((sec) => sec.id != s.id), s];
        state = AsyncValue.data(updated);
      }),
    );
  }

  Future<void> deleteSection(String id) async {
    final result = await _repo.delete(id);
    result.fold(
      (e) => state = AsyncValue.error(e, StackTrace.current),
      (_) => state.whenData(
        (list) =>
            state = AsyncValue.data(list.where((sec) => sec.id != id).toList()),
      ),
    );
  }

  Future<void> reorderSections(List<String> orderedIds) async {
    final result = await _repo.reorder(orderedIds);
    result.fold(
      (e) => state = AsyncValue.error(e, StackTrace.current),
      (_) => state.whenData((list) {
        final map = {for (var sec in list) sec.id: sec};
        final reordered = orderedIds.map((id) => map[id]!).toList();
        state = AsyncValue.data(reordered);
      }),
    );
  }
}
