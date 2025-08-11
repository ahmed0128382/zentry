import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final String time;
  final bool isCompleted;
  final bool showRefresh;

  const TaskItem({
    super.key,
    required this.title,
    required this.time,
    required this.isCompleted,
    required this.showRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: isCompleted,
            onChanged: (bool? newValue) {
              // Handle checkbox state change here
            },
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                decoration: isCompleted ? TextDecoration.lineThrough : null,
                color: isCompleted ? Colors.grey : Colors.black,
              ),
            ),
          ),
          Text(
            time,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
