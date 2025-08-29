import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/application/providers/habits_controller_provider.dart';

class SectionDropdown extends ConsumerWidget {
  final List<String> mainSectionIds;
  final String selectedSectionId;
  final void Function(String) onChanged;
  const SectionDropdown({
    super.key,
    required this.mainSectionIds,
    required this.selectedSectionId,
    required this.onChanged,
    required this.ref,
  });
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<String>>(
      future: ref
          .read(habitsControllerProvider.notifier)
          .getAllSections()
          .then((list) => list.map((s) => s.id).toList())
          .catchError((_) => <String>[]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: CircularProgressIndicator(),
          );
        }

        final userIds = snapshot.data ?? const <String>[];
        final allIds = [
          ...mainSectionIds,
          ...userIds.where((id) => !mainSectionIds.contains(id)),
        ];

        return DropdownButtonFormField<String>(
          decoration: const InputDecoration(
              labelText: 'Section', border: OutlineInputBorder()),
          value: allIds.contains(selectedSectionId)
              ? selectedSectionId
              : 'anytime',
          items: allIds
              .map((id) => DropdownMenuItem<String>(value: id, child: Text(id)))
              .toList(),
          onChanged: (val) {
            if (val != null) onChanged(val);
          },
        );
      },
    );
  }
}
