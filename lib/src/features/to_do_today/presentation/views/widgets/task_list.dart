import 'package:flutter/material.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/task_item.dart';

class TaskList extends StatelessWidget {
  final String title;
  final List<TaskItem> tasks;

  const TaskList({required this.title, required this.tasks, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Optionally, display title here if you want
          // Text(title, style: Theme.of(context).textTheme.headline6),
          ...tasks,
        ],
      ),
    );
  }
}
