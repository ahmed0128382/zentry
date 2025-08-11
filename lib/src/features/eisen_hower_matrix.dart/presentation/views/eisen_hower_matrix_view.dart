import 'package:flutter/material.dart';

class EisenHowerMatrixView extends StatelessWidget {
  const EisenHowerMatrixView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildMatrixBox(
                      context,
                      title: 'Urgent & Important',
                      color: Colors.red,
                      icon: Icons.priority_high,
                      tasks: [
                        _buildTaskItem(
                          context,
                          'صلاة الفجر',
                          '5 Aug, 4:40am',
                          isDone: false,
                        ),
                        _buildTaskItem(
                          context,
                          'Memory quran',
                          'Today, 10:00am',
                          isDone: false,
                        ),
                        _buildTaskItem(
                          context,
                          'Memory quran',
                          '6 Aug, 10:00am',
                          isDone: true,
                        ),
                        _buildTaskItem(
                          context,
                          'Memory quran',
                          '5 Aug, 10:00am',
                          isDone: true,
                        ),
                        _buildTaskItem(
                          context,
                          'صلاة الفجر',
                          '1 Aug, 4:40am',
                          isDone: true,
                        ),
                        _buildTaskItem(
                          context,
                          'Memory quran',
                          '4 Aug, 10:00am',
                          isDone: true,
                        ),
                        _buildTaskItem(
                          context,
                          'Memory quran',
                          '2 Aug, 10:00am',
                          isDone: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildMatrixBox(
                      context,
                      title: 'Not Urgent & Important',
                      color: Colors.yellow,
                      icon: Icons.double_arrow,
                      tasks: [
                        _buildTaskItem(
                          context,
                          'Study flutter',
                          '31 Jul',
                          isDone: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildMatrixBox(
                      context,
                      title: 'Urgent & Unimportant',
                      color: Colors.blue,
                      icon: Icons.info,
                      tasks: [
                        _buildTaskItem(
                          context,
                          'Study UI / UX',
                          '31 Jul',
                          isDone: false,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildMatrixBox(
                      context,
                      title: 'Not Urgent & Unimportant',
                      color: Colors.green,
                      icon: Icons.arrow_downward,
                      tasks: [],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Eisenhower Matrix',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_outlined, color: Colors.grey)),
      ],
    );
  }

  Widget _buildMatrixBox(
    BuildContext context, {
    required String title,
    required Color color,
    required IconData icon,
    required List<Widget> tasks,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 16,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            if (tasks.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'No Tasks',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: tasks,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(
    BuildContext context,
    String title,
    String date, {
    bool isDone = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            isDone ? Icons.check_box_outlined : Icons.check_box_outline_blank,
            color: isDone ? Colors.grey : Colors.grey[400],
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    decoration: isDone ? TextDecoration.lineThrough : null,
                    color: isDone ? Colors.grey : null,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
