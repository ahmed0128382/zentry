import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zentry/src/features/habits/application/controllers/habits_controller.dart';
import 'package:zentry/src/features/habits/application/providers/habits_controller_provider.dart';
import 'package:zentry/src/features/habits/presentation/views/add_habit_view.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/calender_header.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/habit_item.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/habits_view_header.dart';

import 'package:zentry/src/features/habits/domain/entities/habit_details.dart';

class HabitsView extends ConsumerStatefulWidget {
  const HabitsView({super.key});

  @override
  ConsumerState<HabitsView> createState() => _HabitsViewState();
}

class _HabitsViewState extends ConsumerState<HabitsView> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // أول ما يفتح السكرين يبدأ يجيب عادات اليوم الحالي
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(habitsControllerProvider.notifier).watchHabits(_selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(habitsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const HabitsViewHeader(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // افتح شاشة إضافة عادة جديدة
          await context.push(AddHabitView.routeName);
          // بعد ما ترجع من شاشة الإضافة، رجّع عادات اليوم الحالي
          ref
              .read(habitsControllerProvider.notifier)
              .watchHabits(_selectedDate);
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CalendarHeader(
              selectedDate: _selectedDate,
              onDateSelected: (date) {
                setState(() => _selectedDate = date);
                ref.read(habitsControllerProvider.notifier).watchHabits(date);
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _buildBody(state),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(HabitsState state) {
    log('[UI] Number of habits: ${state.habits.length}');
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      log('[UI] Error: ${state.error}');
      return Center(
        child: Text(
          state.error!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (state.habits.isEmpty) {
      log('[UI] No habits to show');
      return const Center(child: Text('No habits yet — add one!'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: state.habits.map((habit) {
          log('[UI] Rendering habit: ${habit.habit.title} (${habit.habit.id})');
          return _buildHabitTile(habit);
        }).toList(),
      ),
    );
  }

  Widget _buildHabitTile(HabitDetails hd) {
    final title = hd.habit.title;
    final target = hd.habit.goal.targetAmount ?? 0;
    final progressText = target > 0 ? 'Target: $target' : null;
    log('[UI] Rendering habit: ${hd.habit.id}, title: ${hd.habit.title}');
    return HabitItem(
      icon: Icons.check_circle_outline,
      iconColor: Colors.blue,
      backgroundColor: Colors.blue.withOpacity(0.08),
      title: title,
      progressText: progressText,
      totalDays: target,
    );
  }
}
// File: lib/src/features/habits/presentation/views/habits_view.dart
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:zentry/src/features/habits/application/controllers/habits_controller.dart';
// import 'package:zentry/src/features/habits/presentation/views/add_habit_view.dart';
// import 'package:zentry/src/features/habits/presentation/views/widgets/habit_item.dart';

// class HabitsView extends ConsumerWidget {
//   const HabitsView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final habitsState = ref.watch(habitsControllerProvider);
//     final habitsController = ref.read(habitsControllerProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Debug Habits')),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           // Open add habit screen
//           final newHabitAdded =
//               await context.push<bool>(AddHabitView.routeName);

//           // If habit was added, refresh list immediately
//           if (newHabitAdded == true) {
//             habitsController.loadAllHabits(); // simplified load for debug
//           }
//         },
//         child: const Icon(Icons.add),
//       ),
//       body: habitsState.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : habitsState.habits.isEmpty
//               ? const Center(child: Text('No habits in DB'))
//               : ListView.builder(
//                   itemCount: habitsState.habits.length,
//                   itemBuilder: (context, index) {
//                     final hd = habitsState.habits[index];
//                     log('Debug UI: ${hd.habit.title}');
//                     return HabitItem(
//                       icon: Icons.check_circle_outline,
//                       iconColor: Colors.blue,
//                       backgroundColor: Colors.blue.withOpacity(0.08),
//                       title: hd.habit.title,
//                       progressText: hd.habit.goal.targetAmount != null
//                           ? 'Target: ${hd.habit.goal.targetAmount}'
//                           : null,
//                       totalDays: hd.habit.goal.targetAmount ?? 0,
//                     );
//                   },
//                 ),
//     );
//   }
// }
