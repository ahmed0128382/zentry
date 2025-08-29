import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zentry/src/features/habits/application/providers/sections_with_habits_controller_provider.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_details.dart';
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
          await ref
              .read(habitsControllerProvider.notifier)
              .toggleCompletion(hd);
          return false;
        }
      },
      child: HabitItem(
        icon: Icons.check_circle_outline,
        iconColor: hd.isCompletedForDay ? Colors.green : Colors.blue,
        backgroundColor: (hd.isCompletedForDay ? Colors.green : Colors.blue)
            .withOpacity(0.08),
        title: hd.habit.title,
        progressText: hd.habit.goal.targetAmount != null
            ? 'Target: ${hd.habit.goal.targetAmount}'
            : null,
        totalDays: hd.habit.goal.targetAmount ?? 0,
        completed: hd.habit.status.isCompleted || hd.isCompletedForDay,
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
