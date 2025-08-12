import 'package:flutter/material.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/completed_tasks.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/task_item.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/task_list.dart';

class TaskContent extends StatelessWidget {
  const TaskContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          TaskList(
            title: 'Inbox',
            tasks: [
              TaskItem(
                title: 'Make zentry',
                time: '7 Aug',
                isCompleted: false,
                showRefresh: true,
              ),
              TaskItem(
                title: 'صلاة الفجر',
                time: '4:40 am',
                isCompleted: false,
                showRefresh: true,
              ),
              TaskItem(
                title: 'Study UI / UX',
                time: '31 Jul',
                isCompleted: false,
                showRefresh: false,
              ),
              TaskItem(
                title: 'Memory quran',
                time: '8 Aug',
                isCompleted: false,
                showRefresh: false,
              ),
            ],
          ),
          Divider(),
          CompletedTasks(),
        ],
      ),
    );
  }
}
