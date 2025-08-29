import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/features/habits/application/providers/sections_with_habits_controller_provider.dart';
import 'package:zentry/src/features/habits/presentation/views/add_habit_view.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/calender_header_widget.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/habits_view_header.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/section_list_widget.dart';

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
