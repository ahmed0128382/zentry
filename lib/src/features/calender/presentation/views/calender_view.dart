import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zentry/src/core/utils/app_colors.dart';

class CalenderView extends StatelessWidget {
  const CalenderView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildCalendar(),
            _buildDivider(),
            _buildTodaySection(),
            _buildDivider(),
            _buildHabitsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final now = DateTime.now();
    final monthFormat = DateFormat.MMM();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            monthFormat.format(now),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.calendar_today, color: Colors.grey),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.grid_view, color: Colors.grey),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final firstDayOfWeek = DateTime(now.year, now.month, 1).weekday;

    final List<String> weekDays = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun'
    ];
    final List<Widget> dayWidgets = [];

    // Add empty cells for days before the 1st
    for (int i = 1; i < firstDayOfWeek; i++) {
      dayWidgets.add(const SizedBox());
    }

    // Add day numbers
    for (int i = 1; i <= daysInMonth; i++) {
      final isToday = i == now.day;
      dayWidgets.add(
        _buildDayCell(i, isToday),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekDays
                .map((day) => Text(
                      day,
                      style: const TextStyle(color: Colors.grey),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 7,
            children: dayWidgets,
          ),
        ],
      ),
    );
  }

  Widget _buildDayCell(int day, bool isToday) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isToday ? AppColors.peacefulSeaBlue.withOpacity(0.8) : null,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$day',
              style: TextStyle(
                color: isToday ? Colors.white : Colors.black,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (!isToday)
              Container(
                margin: const EdgeInsets.only(top: 2),
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Divider(
        height: 1,
        color: Colors.grey,
        indent: 16,
        endIndent: 16,
      ),
    );
  }

  Widget _buildTodaySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TODAY',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildTaskItem(
            'صلاة الفجر',
            '4:40am',
            isCompleted: false,
            showRefresh: true,
          ),
          _buildTaskItem(
            'Memory quran',
            '10:00am',
            isCompleted: false,
            showRefresh: false,
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(String title, String time,
      {required bool isCompleted, required bool showRefresh}) {
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

  Widget _buildHabitsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'HABIT',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildHabitItem(
            'Brush your teeth',
            Icons.spa, // Using spa for a generic 'clean' icon
            'Today',
          ),
          _buildHabitItem(
            'Early to bed',
            Icons.bedtime,
            'Today',
          ),
          _buildHabitItem(
            'Any sport daily',
            Icons.directions_run,
            'Today',
          ),
          _buildHabitItem(
            'Check before bed that u are fine',
            Icons.sentiment_satisfied_alt,
            'Today',
          ),
        ],
      ),
    );
  }

  Widget _buildHabitItem(String title, IconData icon, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.peacefulSeaBlue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(title),
          ),
          Text(
            time,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.check_circle, color: Colors.grey),
        ],
      ),
    );
  }
}
