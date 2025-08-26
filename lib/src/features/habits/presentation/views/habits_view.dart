// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:zentry/src/features/habits/application/controllers/habits_controller.dart';
// import 'package:zentry/src/features/habits/application/providers/habits_controller_provider.dart';
// import 'package:zentry/src/features/habits/presentation/views/add_habit_view.dart';
// import 'package:zentry/src/features/habits/presentation/views/widgets/calender_header.dart';
// import 'package:zentry/src/features/habits/presentation/views/widgets/habit_item.dart';
// import 'package:zentry/src/features/habits/presentation/views/widgets/habits_view_header.dart';

// import 'package:zentry/src/features/habits/domain/entities/habit_details.dart';

// class HabitsView extends ConsumerStatefulWidget {
//   const HabitsView({super.key});

//   @override
//   ConsumerState<HabitsView> createState() => _HabitsViewState();
// }

// class _HabitsViewState extends ConsumerState<HabitsView> {
//   DateTime _selectedDate = DateTime.now();

//   @override
//   void initState() {
//     super.initState();
//     // أول ما يفتح السكرين يبدأ يجيب عادات اليوم الحالي
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(habitsControllerProvider.notifier).watchHabits(_selectedDate);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(habitsControllerProvider);

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const HabitsViewHeader(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           // افتح شاشة إضافة عادة جديدة
//           await context.push(AddHabitView.routeName);
//           // بعد ما ترجع من شاشة الإضافة، رجّع عادات اليوم الحالي
//           ref
//               .read(habitsControllerProvider.notifier)
//               .watchHabits(_selectedDate);
//         },
//         child: const Icon(Icons.add),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             CalendarHeader(
//               selectedDate: _selectedDate,
//               onDateSelected: (date) {
//                 setState(() => _selectedDate = date);
//                 ref.read(habitsControllerProvider.notifier).watchHabits(date);
//               },
//             ),
//             const SizedBox(height: 12),
//             Expanded(
//               child: _buildBody(state),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBody(HabitsState state) {
//     log('[UI] Number of habits: ${state.habits.length}');
//     if (state.isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (state.error != null) {
//       log('[UI] Error: ${state.error}');
//       return Center(
//         child: Text(
//           state.error!,
//           style: const TextStyle(color: Colors.red),
//         ),
//       );
//     }

//     if (state.habits.isEmpty) {
//       log('[UI] No habits to show');
//       return const Center(child: Text('No habits yet — add one!'));
//     }

//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: state.habits.map((habit) {
//           log('[UI] Rendering habit: ${habit.habit.title} (${habit.habit.id})');
//           return _buildHabitTile(habit);
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildHabitTile(HabitDetails hd) {
//     final title = hd.habit.title;
//     final target = hd.habit.goal.targetAmount ?? 0;
//     final progressText = target > 0 ? 'Target: $target' : null;
//     log('[UI] Rendering habit: ${hd.habit.id}, title: ${hd.habit.title}');
//     return HabitItem(
//       icon: Icons.check_circle_outline,
//       iconColor: Colors.blue,
//       backgroundColor: Colors.blue.withOpacity(0.08),
//       title: title,
//       progressText: progressText,
//       totalDays: target,
//     );
//   }
// }
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zentry/src/features/habits/application/controllers/habits_controller.dart';
import 'package:zentry/src/features/habits/application/providers/habits_controller_provider.dart';
import 'package:zentry/src/features/habits/presentation/views/add_habit_view.dart';
import 'package:zentry/src/features/habits/presentation/views/edit_habit_view.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/calender_header.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/habit_item.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/habits_view_header.dart';

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
          final added = await context.push<bool>(AddHabitView.routeName);
          if (added == true && mounted) {
            ref
                .read(habitsControllerProvider.notifier)
                .watchHabits(_selectedDate);
          }
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
            Expanded(child: _buildBody(state)),
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
        child: Text(state.error!, style: const TextStyle(color: Colors.red)),
      );
    }

    if (state.habits.isEmpty) {
      log('[UI] No habits to show');
      return const Center(child: Text('No habits yet — add one!'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.habits.length,
      itemBuilder: (_, idx) {
        final hd = state.habits[idx];
        log('[UI] Rendering habit: ${hd.habit.title} (${hd.habit.id})');

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
              // delete
              final ok = await _confirmDelete(context);
              if (ok == true) {
                ref.read(habitsControllerProvider.notifier).delete(hd.habit.id);
              }
              return ok ?? false;
            } else {
              // mark complete for today
              await ref
                  .read(habitsControllerProvider.notifier)
                  .logCompletion(hd);
              return false; // keep item
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
            completed: hd.isCompletedForDay,
            onTap: () async {
              final edited = await context.push<bool>(
                EditHabitView.routeName,
                extra: hd.habit,
              );
              if (edited == true && mounted) {
                ref
                    .read(habitsControllerProvider.notifier)
                    .watchHabits(_selectedDate);
              }
            },
            onMore: (choice) async {
              if (choice == HabitItemMenu.edit) {
                final edited = await context.push<bool>(
                  EditHabitView.routeName,
                  extra: hd.habit,
                );
                if (edited == true && mounted) {
                  ref
                      .read(habitsControllerProvider.notifier)
                      .watchHabits(_selectedDate);
                }
              } else if (choice == HabitItemMenu.complete) {
                await ref
                    .read(habitsControllerProvider.notifier)
                    .logCompletion(hd);
              } else if (choice == HabitItemMenu.delete) {
                final ok = await _confirmDelete(context);
                if (ok == true) {
                  ref
                      .read(habitsControllerProvider.notifier)
                      .delete(hd.habit.id);
                }
              }
            },
          ),
        );
      },
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
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
  }
}
