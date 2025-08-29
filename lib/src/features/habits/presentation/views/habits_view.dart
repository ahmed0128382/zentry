// // File: src/features/habits/presentation/views/habits_view.dart

// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
// import 'package:zentry/src/features/habits/application/providers/sections_with_habits_controller_provider.dart';
// import 'package:zentry/src/features/habits/application/states/sections_with_habits_state.dart';
// import 'package:zentry/src/features/habits/application/providers/habits_controller_provider.dart';
// import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
// import 'package:zentry/src/features/habits/domain/enums/section_type.dart';
// import 'package:zentry/src/features/habits/presentation/views/add_habit_view.dart';
// import 'package:zentry/src/features/habits/presentation/views/edit_habit_view.dart';
// import 'package:zentry/src/features/habits/presentation/views/widgets/calender_header.dart';
// import 'package:zentry/src/features/habits/presentation/views/widgets/habit_item.dart';
// import 'package:zentry/src/features/habits/presentation/views/widgets/habits_view_header.dart';

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
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref
//           .read(sectionsWithHabitsControllerProvider.notifier)
//           .watchSections(_selectedDate);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(sectionsWithHabitsControllerProvider);
//     final palette = ref.watch(appPaletteProvider);

//     return Scaffold(
//       backgroundColor: palette.background,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: palette.primary,
//         elevation: 0,
//         title: const HabitsViewHeader(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: palette.primary.withOpacity(0.8),
//         onPressed: () async {
//           final added = await context.push<bool>(AddHabitView.routeName);
//           if (added == true && mounted) {
//             ref
//                 .read(sectionsWithHabitsControllerProvider.notifier)
//                 .watchSections(_selectedDate);
//           }
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
//                 ref
//                     .read(sectionsWithHabitsControllerProvider.notifier)
//                     .watchSections(date);
//               },
//             ),
//             const SizedBox(height: 12),
//             Expanded(child: _buildBody(state)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBody(SectionsWithHabitsState state) {
//     log('[UI] Number of sections: ${state.sections.length}');
//     if (state.isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (state.error != null) {
//       log('[UI] Error: ${state.error}');
//       return Center(
//         child: Text(state.error!, style: const TextStyle(color: Colors.red)),
//       );
//     }

//     if (state.sections.isEmpty) {
//       log('[UI] No sections to show');
//       return const Center(child: Text('No habits yet — add one!'));
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: state.sections.length,
//       itemBuilder: (_, idx) {
//         final sectionWithHabits = state.sections[idx];
//         final SectionType sectionType = sectionWithHabits.section.type;

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Section header
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Row(
//                 children: [
//                   Icon(sectionType.icon, size: 18),
//                   const SizedBox(width: 6),
//                   Text(
//                     sectionType.displayName,
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                 ],
//               ),
//             ),

//             // Habits inside section
//             ...sectionWithHabits.habits.map((hd) {
//               return Dismissible(
//                 key: ValueKey(hd.habit.id),
//                 background: Container(
//                   color: Colors.red,
//                   alignment: Alignment.centerLeft,
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: const Icon(Icons.delete, color: Colors.white),
//                 ),
//                 secondaryBackground: Container(
//                   color: Colors.green,
//                   alignment: Alignment.centerRight,
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: const Icon(Icons.check, color: Colors.white),
//                 ),
//                 confirmDismiss: (direction) async {
//                   if (direction == DismissDirection.startToEnd) {
//                     final ok = await _confirmDelete(context);
//                     if (ok == true) {
//                       ref
//                           .read(habitsControllerProvider.notifier)
//                           .delete(hd.habit.id);
//                     }
//                     return ok ?? false;
//                   } else {
//                     await ref
//                         .read(habitsControllerProvider.notifier)
//                         .toggleCompletion(hd);
//                     return false;
//                   }
//                 },
//                 child: HabitItem(
//                   icon: Icons.check_circle_outline,
//                   iconColor: hd.isCompletedForDay ? Colors.green : Colors.blue,
//                   backgroundColor:
//                       (hd.isCompletedForDay ? Colors.green : Colors.blue)
//                           .withOpacity(0.08),
//                   title: hd.habit.title,
//                   progressText: hd.habit.goal.targetAmount != null
//                       ? 'Target: ${hd.habit.goal.targetAmount}'
//                       : null,
//                   totalDays: hd.habit.goal.targetAmount ?? 0,
//                   completed:
//                       hd.habit.status.isCompleted || hd.isCompletedForDay,
//                   onTap: () async {
//                     final edited = await context.push<bool>(
//                       EditHabitView.routeName,
//                       extra: hd,
//                     );
//                     if (edited == true && mounted) {
//                       ref
//                           .read(sectionsWithHabitsControllerProvider.notifier)
//                           .watchSections(_selectedDate);
//                     }
//                   },
//                 ),
//               );
//             }),
//             const Divider(),
//           ],
//         );
//       },
//     );
//   }

//   Future<bool?> _confirmDelete(BuildContext context) {
//     return showDialog<bool>(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('Delete habit?'),
//         content: const Text('This cannot be undone.'),
//         actions: [
//           TextButton(
//               onPressed: () => Navigator.pop(ctx, false),
//               child: const Text('Cancel')),
//           FilledButton(
//               onPressed: () => Navigator.pop(ctx, true),
//               child: const Text('Delete')),
//         ],
//       ),
//     );
//   }
// }
// File: src/features/habits/presentation/views/habits_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/features/habits/application/providers/sections_with_habits_controller_provider.dart';
import 'package:zentry/src/features/habits/application/states/sections_with_habits_state.dart';
import 'package:zentry/src/features/habits/application/providers/habits_controller_provider.dart';
import 'package:zentry/src/features/habits/domain/enums/section_type.dart';
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
      ref
          .read(sectionsWithHabitsControllerProvider.notifier)
          .watchSections(_selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sectionsWithHabitsControllerProvider);
    final palette = ref.watch(appPaletteProvider);

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: palette.primary,
        elevation: 0,
        title: const HabitsViewHeader(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: palette.primary.withOpacity(0.8),
        onPressed: () async {
          final added = await context.push<bool>(AddHabitView.routeName);
          if (added == true && mounted) {
            ref
                .read(sectionsWithHabitsControllerProvider.notifier)
                .watchSections(_selectedDate);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CalendarHeaderWidget(
              selectedDate: _selectedDate,
              onDateSelected: (date) {
                setState(() => _selectedDate = date);
                ref
                    .read(sectionsWithHabitsControllerProvider.notifier)
                    .watchSections(date);
              },
            ),
            const SizedBox(height: 12),
            Expanded(
                child: SectionsListWidget(
                    state: state, selectedDate: _selectedDate, ref: ref)),
          ],
        ),
      ),
    );
  }
}

/// Calendar Header as Widget
class CalendarHeaderWidget extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const CalendarHeaderWidget({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CalendarHeader(
      selectedDate: selectedDate,
      onDateSelected: onDateSelected,
    );
  }
}

/// Sections + Habits List as Widget
class SectionsListWidget extends StatelessWidget {
  final SectionsWithHabitsState state;
  final DateTime selectedDate;
  final WidgetRef ref;

  const SectionsListWidget({
    super.key,
    required this.state,
    required this.selectedDate,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Text(state.error!, style: const TextStyle(color: Colors.red)),
      );
    }

    if (state.sections.isEmpty) {
      return const Center(child: Text('No habits yet — add one!'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.sections.length,
      itemBuilder: (_, idx) {
        final sectionWithHabits = state.sections[idx];
        return SectionWidget(
          sectionWithHabits: sectionWithHabits,
          selectedDate: selectedDate,
          ref: ref,
        );
      },
    );
  }
}

/// Single Section as Widget
class SectionWidget extends StatelessWidget {
  final dynamic sectionWithHabits;
  final DateTime selectedDate;
  final WidgetRef ref;

  const SectionWidget({
    super.key,
    required this.sectionWithHabits,
    required this.selectedDate,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final SectionType sectionType = sectionWithHabits.section.type;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderWidget(sectionType: sectionType),
        ...sectionWithHabits.habits.map(
          (hd) => HabitItemWidget(hd: hd, ref: ref, selectedDate: selectedDate),
        ),
        const Divider(),
      ],
    );
  }
}

/// Section Header as Widget
class SectionHeaderWidget extends StatelessWidget {
  final SectionType sectionType;

  const SectionHeaderWidget({super.key, required this.sectionType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(sectionType.icon, size: 18),
          const SizedBox(width: 6),
          Text(
            sectionType.displayName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

/// Single Habit Item as Widget
class HabitItemWidget extends ConsumerWidget {
  final dynamic hd;
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
