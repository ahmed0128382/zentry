// Today section listing tasks
import 'package:flutter/material.dart';

class TodaySection extends StatelessWidget {
  const TodaySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TODAY',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // TaskItem(
          //   title: 'صلاة الفجر',
          //   time: '4:40am',
          //   isCompleted: false,
          //   showRefresh: true,
          // ),
          // TaskItem(
          //   title: 'Memory quran',
          //   time: '10:00am',
          //   isCompleted: false,
          //   showRefresh: false,
          // ),
        ],
      ),
    );
  }
}
