// File: src/features/habits/presentation/views/widgets/habit_item_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zentry/src/features/habits/application/providers/sections_with_habits_controller_provider.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_details.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_log.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/habit_item.dart';
import 'package:zentry/src/features/habits/application/providers/habits_controller_provider.dart';
import 'package:zentry/src/features/habits/presentation/views/edit_habit_view.dart';

/// Single Habit Item as Widget
class HabitItemWidget extends ConsumerWidget {
  final HabitDetails hd;
  final WidgetRef ref;
  final DateTime selectedDate;

  const HabitItemWidget({
    super.key,
    required this.hd,
    required this.ref,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the log for the selected day, fallback to default log if missing
    final logForSelectedDay = hd.logs.firstWhere(
      (log) =>
          log.date.year == selectedDate.year &&
          log.date.month == selectedDate.month &&
          log.date.day == selectedDate.day,
      orElse: () => HabitLog(
        id: '', // placeholder id
        habitId: hd.habit.id,
        date: selectedDate,
        amount: 0, // default amount
      ),
    );

    final currentAmount = logForSelectedDay.amount;
    final targetAmount = hd.habit.goal.targetAmount ?? 0;
    final completedToday = currentAmount >= targetAmount;

    return Dismissible(
      key: ValueKey(hd.habit.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.green,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(Icons.check, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          final ok = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Delete habit?'),
              content: const Text('This cannot be undone.'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('Cancel')),
                FilledButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text('Delete')),
              ],
            ),
          );
          if (ok == true) {
            ref.read(habitsControllerProvider.notifier).delete(hd.habit.id);
          }
          return ok ?? false;
        } else {
          // Call controller to handle increment (no manual +1 here)
          if (!completedToday && targetAmount > 0) {
            await ref
                .read(habitsControllerProvider.notifier)
                .updateLog(logForSelectedDay);
          }
          return false;
        }
      },
      child: HabitItem(
        icon: Icons.check_circle_outline,
        iconColor: completedToday ? Colors.green : Colors.blue,
        backgroundColor:
            (completedToday ? Colors.green : Colors.blue).withOpacity(0.08),
        title: hd.habit.title,
        progressText: targetAmount > 0
            ? 'Progress: ${logForSelectedDay.amount} / $targetAmount'
            : null,
        totalDays: targetAmount,
        completed: hd.habit.status.isCompleted || completedToday,
        onTap: () async {
          final edited = await context.push<bool>(
            EditHabitView.routeName,
            extra: hd,
          );
          if (edited == true && context.mounted) {
            ref
                .read(sectionsWithHabitsControllerProvider.notifier)
                .watchSections(selectedDate);
          }
        },
      ),
    );
  }
}
