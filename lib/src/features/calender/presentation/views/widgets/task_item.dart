// Single task item in today section
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final String time;
  final bool isCompleted;
  final bool showRefresh;

  const TaskItem({
    required this.title,
    required this.time,
    required this.isCompleted,
    required this.showRefresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          if (showRefresh)
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.refresh),
            ),
          Expanded(
            child: Row(
              children: [
                if (!showRefresh)
                  Checkbox(
                    value: isCompleted,
                    onChanged: (bool? newValue) {},
                  ),
                Text(
                  title,
                  style: TextStyle(
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
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
