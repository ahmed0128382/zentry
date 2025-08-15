import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/to_do_today/application/providers/task_details_controller_provider.dart';

Future<bool?> showDiscardDialog(
    BuildContext context, WidgetRef ref, String taskId) {
  final controller = ref.read(taskDetailsControllerProvider(taskId).notifier);
  return showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Unsaved changes'),
      content: const Text('You have unsaved edits. What would you like to do?'),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel')),
        TextButton(
          onPressed: () async {
            await controller.saveEdits();
            if (ctx.mounted) Navigator.pop(ctx, true);
          },
          child: const Text('Save'),
        ),
        FilledButton.tonal(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Discard')),
      ],
    ),
  );
}

Future<bool?> showDeleteDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Delete task?'),
      content: const Text('This action cannot be undone.'),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel')),
        FilledButton.tonal(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete')),
      ],
    ),
  );
}
