import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/application/providers/quadrant_overlay_controller_provider.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/domain/enums/quadrant_type_enum.dart';

class QuadrantOverlay extends ConsumerWidget {
  final VoidCallback? onDismiss;

  const QuadrantOverlay({super.key, this.onDismiss});

  Color _getPriorityColor(QuadrantType quadrant) {
    switch (quadrant) {
      case QuadrantType.urgentImportant:
        return Colors.red;
      case QuadrantType.notUrgentImportant:
        return Colors.orange;
      case QuadrantType.urgentNotImportant:
        return Colors.green;
      case QuadrantType.notUrgentNotImportant:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedQuadrant = ref.watch(quadrantOverlayControllerProvider);

    return PopupMenuButton<QuadrantType>(
      child: Text(
        selectedQuadrant.name.toUpperCase(),
        style: TextStyle(
          color: _getPriorityColor(selectedQuadrant),
          fontWeight: FontWeight.bold,
        ),
      ),
      onSelected: (quadrant) {
        ref
            .read(quadrantOverlayControllerProvider.notifier)
            .selectPriority(quadrant);
        if (onDismiss != null) onDismiss!();
      },
      itemBuilder: (context) => QuadrantType.values.map((quadrant) {
        return PopupMenuItem<QuadrantType>(
          value: quadrant,
          child: Text(
            quadrant.name.toUpperCase(),
            style: TextStyle(color: _getPriorityColor(quadrant)),
          ),
        );
      }).toList(),
    );
  }
}
