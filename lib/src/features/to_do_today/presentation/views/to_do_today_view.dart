import 'package:flutter/material.dart';

class ToDoTodayView extends StatelessWidget {
  const ToDoTodayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Current tasks section
            _buildTaskList(
              title: 'Inbox',
              tasks: [
                _TaskItem(
                  taskName: 'Make zentry',
                  date: '7 Aug',
                  isChecked: false,
                ),
                _TaskItem(
                  taskName: 'صلاة الفجر',
                  date: '4:40 am',
                  isChecked: false,
                ),
                _TaskItem(
                  taskName: 'Study UI / UX',
                  date: '31 Jul',
                  isChecked: false,
                ),
                _TaskItem(
                  taskName: 'Memory quran',
                  date: '8 Aug',
                  isChecked: false,
                ),
              ],
            ),
            const Divider(), // Separator line

            // Completed tasks section
            _buildCompletedTasks(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskList({required String title, required List<Widget> tasks}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: tasks,
      ),
    );
  }

  Widget _buildCompletedTasks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'COMPLETED',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Row(
                children: const [
                  Text(
                    '5',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                ],
              ),
            ],
          ),
        ),
        // Completed tasks list
        _TaskItem(
          taskName: 'صلاة الفجر',
          date: '5 Aug',
          isChecked: true,
        ),
        _TaskItem(
          taskName: 'Memory quran',
          date: '7 Aug',
          isChecked: true,
        ),
        _TaskItem(
          taskName: 'Study flutter',
          date: '31 Jul',
          isChecked: true,
        ),
        _TaskItem(
          taskName: 'Memory quran',
          date: '6 Aug',
          isChecked: true,
        ),
        _TaskItem(
          taskName: 'Memory quran',
          date: '5 Aug',
          isChecked: true,
        ),
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
    );
  }
}

class _TaskItem extends StatelessWidget {
  final String taskName;
  final String date;
  final bool isChecked;

  const _TaskItem({
    required this.taskName,
    required this.date,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (bool? newValue) {
              // Handle checkbox state change here
            },
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              taskName,
              style: TextStyle(
                decoration: isChecked ? TextDecoration.lineThrough : null,
                color: isChecked ? Colors.grey : Colors.black,
              ),
            ),
          ),
          Text(
            date,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
