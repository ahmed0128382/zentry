// ✅ This is correct for views inside IndexedStack in MainViewBody
import 'package:flutter/material.dart';

class ToDoTodayView extends StatelessWidget {
  const ToDoTodayView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Tasks for Today'));
  }
}
