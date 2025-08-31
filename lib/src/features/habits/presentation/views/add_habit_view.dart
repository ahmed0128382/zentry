import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/features/habits/application/providers/habits_controller_provider.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_goal.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_reminder.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_frequency.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_goal_period.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_goal_record_mode.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_goal_type.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_goal_unit.dart';
import 'package:zentry/src/features/habits/domain/enums/weekday.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
import 'package:zentry/src/features/habits/domain/value_objects/weekday_mask.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_log.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_details.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/date_button.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/drop_down_widget.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/number_field.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/reminders_section.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/section_drop_down.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/text_field_widget.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/week_days_selector.dart';
import 'package:zentry/src/shared/domain/entities/habit.dart';

class AddHabitView extends ConsumerStatefulWidget {
  const AddHabitView({super.key});
  static const routeName = '/add-habit';

  @override
  ConsumerState<AddHabitView> createState() => _AddHabitViewState();
}

class _AddHabitViewState extends ConsumerState<AddHabitView> {
  final TextEditingController _nameCtrl = TextEditingController();
  HabitFrequency _frequency = HabitFrequency.daily;
  HabitGoalType _goalType = HabitGoalType.reachAmount;
  HabitGoalUnit _goalUnit = HabitGoalUnit.times;
  HabitGoalPeriod _goalPeriod = HabitGoalPeriod.perDay;
  HabitGoalRecordMode _goalRecordMode = HabitGoalRecordMode.auto;
  HabitStatus _status = HabitStatus.active;

  final Set<Weekday> _selectedDays = {};
  int? _targetAmount;
  DateTime? _startDate;
  DateTime? _endDate;
  final List<TimeOfDay> _reminders = [];

  String _selectedSectionId = 'anytime';
  static const List<String> _mainSectionIds = [
    'morning',
    'afternoon',
    'evening',
    'anytime',
  ];

  @override
  Widget build(BuildContext context) {
    final palette = ref.watch(appPaletteProvider);
    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        title: const Text('Add Habit'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveHabit,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFieldWidget(controller: _nameCtrl, label: 'Habit Name'),
            const SizedBox(height: 16),
            DropdownWidget<HabitFrequency>(
              label: 'Frequency',
              value: _frequency,
              items: HabitFrequency.values,
              onChanged: (val) {
                setState(() {
                  _frequency = val;
                  if (_frequency != HabitFrequency.weekly) {
                    _selectedDays.clear();
                  }
                });
              },
            ),
            if (_frequency == HabitFrequency.weekly)
              WeekdaySelector(
                selectedDays: _selectedDays,
                onChanged: (newSet) {
                  setState(() {
                    _selectedDays
                      ..clear()
                      ..addAll(newSet);
                  });
                },
              ),
            const SizedBox(height: 16),
            DropdownWidget<HabitGoalType>(
              label: 'Goal Type',
              value: _goalType,
              items: HabitGoalType.values,
              onChanged: (val) => setState(() => _goalType = val),
            ),
            const SizedBox(height: 16),
            DropdownWidget<HabitGoalUnit>(
              label: 'Goal Unit',
              value: _goalUnit,
              items: HabitGoalUnit.values,
              onChanged: (val) => setState(() => _goalUnit = val),
            ),
            const SizedBox(height: 16),
            DropdownWidget<HabitGoalPeriod>(
              label: 'Goal Period',
              value: _goalPeriod,
              items: HabitGoalPeriod.values,
              onChanged: (val) => setState(() => _goalPeriod = val),
            ),
            const SizedBox(height: 16),
            DropdownWidget<HabitGoalRecordMode>(
              label: 'Record Mode',
              value: _goalRecordMode,
              items: HabitGoalRecordMode.values,
              onChanged: (val) => setState(() => _goalRecordMode = val),
            ),
            const SizedBox(height: 16),
            NumberField(
              label: 'Target Amount',
              onChanged: (val) => _targetAmount = int.tryParse(val),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DateButton(
                    label: _startDate == null
                        ? 'Start date'
                        : 'Start: ${_startDate!.toLocal().toString().split(' ').first}',
                    initialDate: _startDate,
                    onPick: (d) => setState(() => _startDate = d),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DateButton(
                    label: _endDate == null
                        ? 'End date (optional)'
                        : 'End: ${_endDate!.toLocal().toString().split(' ').first}',
                    initialDate: _endDate,
                    onPick: (d) => setState(() => _endDate = d),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SectionDropdown(
              mainSectionIds: _mainSectionIds,
              selectedSectionId: _selectedSectionId,
              onChanged: (val) => setState(() => _selectedSectionId = val),
              ref: ref,
            ),
            const SizedBox(height: 16),
            DropdownWidget<HabitStatus>(
              label: 'Status',
              value: _status,
              items: HabitStatus.values,
              onChanged: (val) => setState(() => _status = val),
            ),
            const SizedBox(height: 16),
            RemindersSection(
              reminders: _reminders,
              onPickReminder: (time) => setState(() => _reminders.add(time)),
              onRemoveReminder: (time) =>
                  setState(() => _reminders.remove(time)),
            ),
          ],
        ),
      ),
    );
  }

  void _saveHabit() async {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a habit name')),
      );
      return;
    }

    final now = DateTime.now();
    final habitId = now.millisecondsSinceEpoch.toString();

    final habit = Habit(
      id: habitId,
      title: name,
      description: null,
      sectionId: _selectedSectionId,
      status: _status,
      frequency: _frequency,
      weeklyDays: _frequency == HabitFrequency.weekly
          ? WeekdayMask.fromDays(_selectedDays)
          : null,
      intervalDays: (_frequency != HabitFrequency.daily &&
              _frequency != HabitFrequency.weekly)
          ? _targetAmount
          : null,
      goal: HabitGoal(
        type: _goalType,
        unit: _goalUnit,
        period: _goalPeriod,
        recordMode: _goalRecordMode,
        targetAmount: _targetAmount,
        startDate: _startDate,
        endDate: _endDate,
      ),
      createdAt: now,
      updatedAt: now,
      autoPopup: true,
    );

    // Initialize logs list, preserving any logic if your controller expects it
    final habitDetails = HabitDetails(
      habit: habit,
      logs: [], // Start empty; controller can create today's log automatically
      reminders: _reminders
          .map((time) => HabitReminder(
                id: '${habitId}_${time.hour * 60 + time.minute}',
                habitId: habitId,
                minutesSinceMidnight: time.hour * 60 + time.minute,
                enabled: true,
              ))
          .toList(),
    );

    final habitsCtrl = ref.read(habitsControllerProvider.notifier);
    await habitsCtrl.add(habit, reminders: habitDetails.reminders);

    // Optionally: set today’s status after adding
    await habitsCtrl.setTodayStatus(habit.id, HabitStatus.active);

    if (mounted) Navigator.pop(context, true);
  }
}
