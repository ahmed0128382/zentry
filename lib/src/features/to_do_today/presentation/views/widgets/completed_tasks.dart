import 'package:flutter/material.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/completed_header.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/task_item.dart';

class CompletedTasks extends StatelessWidget {
  const CompletedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CompletedHeader(),
          const TaskItem(
            title: 'صلاة الفجر',
            time: '5 Aug',
            isCompleted: true,
            showRefresh: true,
          ),
          const TaskItem(
              title: 'Memory quran',
              time: '7 Aug',
              isCompleted: true,
              showRefresh: false),
          const TaskItem(
              title: 'Study flutter',
              time: '31 Jul',
              isCompleted: true,
              showRefresh: false),
          const TaskItem(
              title: 'Memory quran',
              time: '6 Aug',
              isCompleted: true,
              showRefresh: false),
          const TaskItem(
              title: 'Memory quran',
              time: '5 Aug',
              isCompleted: true,
              showRefresh: false),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'View more',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
