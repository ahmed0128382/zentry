import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/application/providers/eisenhower_matrix_controller_provider.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/application/providers/quadrant_overlay_controller_provider.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/domain/enums/quadrant_type_enum.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/presentation/views/widgets/quadrant_overlay.dart';
import 'package:zentry/src/features/to_do_today/application/providers/task_list_controller_provider.dart';
import 'package:zentry/src/shared/domain/entities/task.dart';


class AddTaskBottomSheet extends ConsumerStatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;

  const AddTaskBottomSheet({
    super.key,
    required this.titleFocusNode,
    required this.descriptionFocusNode,
  });

  @override
  ConsumerState<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends ConsumerState<AddTaskBottomSheet> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height * 0.45;
    final palette = ref.watch(appPaletteProvider);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: palette.primary.withOpacity(0.8),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Title
                TextField(
                  focusNode: widget.titleFocusNode,
                  
                  controller: titleController,
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    hintText: 'What would you like to do?',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: palette.text),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  minLines: 1,
                  maxLines: null,
                ),

                const SizedBox(height: 6),

                // Description
                TextField(
                  focusNode: widget.descriptionFocusNode,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Description (optional)',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: palette.text),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  minLines: 1,
                  maxLines: null,
                ),

                const SizedBox(height: 8),

                // Actions row
                Row(
                  children: [
                    const QuadrantOverlay(),
                    const SizedBox(width: 2),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                      icon: Icon(Icons.more_horiz, color: palette.text),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final title = titleController.text.trim();
                        if (title.isEmpty) return;

                        final selectedPriority =
                            ref.read(quadrantOverlayControllerProvider);

                        final newTask = Task(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          title: title,
                          description: descriptionController.text.trim(),
                          priority: selectedPriority.toPriority(),
                        );

                        ref
                            .read(taskListControllerProvider.notifier)
                            .addTask(newTask);
                        ref
                            .read(eisenhowerMatrixControllerProvider.notifier)
                            .closeSheet();

                        // Reset state
                        ref
                            .read(quadrantOverlayControllerProvider.notifier)
                            .clearPriority();
                        titleController.clear();
                        descriptionController.clear();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
