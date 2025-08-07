import 'package:flutter/material.dart';

class HabitsView extends StatelessWidget {
  const HabitsView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(context),
          _buildCalendarHeader(context),
          SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Others'),
                    _buildHabitItem(
                      context,
                      icon: Icons.brush,
                      iconColor: Colors.blue,
                      backgroundColor: Colors.blue.withOpacity(0.1),
                      title: 'Brush your teeth',
                      totalDays: 7,
                    ),
                    _buildHabitItem(
                      context,
                      icon: Icons.bedtime,
                      iconColor: Colors.deepPurple,
                      backgroundColor: Colors.deepPurple.withOpacity(0.1),
                      title: 'Early to bed',
                      totalDays: 7,
                    ),
                    _buildHabitItem(
                      context,
                      icon: Icons.directions_run,
                      iconColor: Colors.orange,
                      backgroundColor: Colors.orange.withOpacity(0.1),
                      title: 'Any sport daily',
                      totalDays: 1,
                    ),
                    _buildHabitItem(
                      context,
                      icon: Icons.check,
                      iconColor: Colors.red,
                      backgroundColor: Colors.red.withOpacity(0.1),
                      title: 'Check before bed that u a...',
                      progressText: '0/1 Count',
                      totalDays: 5,
                    ),
                    _buildHabitItem(
                      context,
                      icon: Icons.local_drink,
                      iconColor: Colors.teal,
                      backgroundColor: Colors.teal.withOpacity(0.1),
                      title: 'Drink water',
                      progressText: '0/7 Cup',
                      totalDays: 6,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Habit Tracker',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.access_time),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.bookmark_border),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.sort),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCalendarHeader(BuildContext context) {
    // A simplified calendar header. The actual implementation might be more complex.
    final List<String> daysOfWeek = [
      'Fri',
      'Sat',
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu'
    ];
    final List<int> dates = [1, 2, 3, 4, 5, 6, 7];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      color: Theme.of(context).cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(7, (index) {
          final bool isToday = dates[index] == 7; // Assuming today is the 7th
          return _buildCalendarDay(
            context,
            day: daysOfWeek[index],
            date: dates[index],
            isToday: isToday,
          );
        }),
      ),
    );
  }

  Widget _buildCalendarDay(BuildContext context,
      {required String day, required int date, required bool isToday}) {
    return Container(
      width: 40,
      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(
              color: isToday ? Colors.blue : Colors.grey,
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(height: 4),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isToday ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              date.toString(),
              style: TextStyle(
                color: isToday ? Colors.white : Colors.black,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Text(
                '5',
                style: TextStyle(color: Colors.grey),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHabitItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required String title,
    String? progressText,
    required int totalDays,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                if (progressText != null) ...[
                  SizedBox(height: 4),
                  Text(
                    progressText,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                totalDays.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Total Days',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
