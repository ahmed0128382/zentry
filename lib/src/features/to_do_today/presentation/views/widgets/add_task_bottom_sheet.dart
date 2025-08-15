import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/to_do_today/application/providers/task_list_controller_provider.dart';
import 'package:zentry/src/features/to_do_today/application/providers/to_do_today_controller_provider.dart';
import 'package:zentry/src/features/to_do_today/domain/entities/task.dart';

class AddTaskBottomSheet extends ConsumerWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;

  const AddTaskBottomSheet({
    super.key,
    required this.titleFocusNode,
    required this.descriptionFocusNode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double maxHeight = MediaQuery.of(context).size.height * 0.45;
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                TextField(
                  focusNode: titleFocusNode,
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'What would you like to do?',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  minLines: 1,
                  maxLines: null,
                ),
                const SizedBox(height: 6),
                TextField(
                  focusNode: descriptionFocusNode,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Description (optional)',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  minLines: 1,
                  maxLines: null,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                      icon: const Icon(Icons.calendar_today_outlined,
                          color: Colors.grey),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                      icon: const Icon(Icons.bookmark_outline,
                          color: Colors.grey),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                      icon: const Icon(Icons.label_outline, color: Colors.grey),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz, color: Colors.grey),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final title = titleController.text.trim();
                        if (title.isEmpty) return;

                        final newTask = Task(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          title: title,
                          description: descriptionController.text.trim(),
                        );

                        ref
                            .read(taskListControllerProvider.notifier)
                            .addTask(newTask);

                        ref
                            .read(toDoTodayControllerProvider.notifier)
                            .closeSheet();
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
