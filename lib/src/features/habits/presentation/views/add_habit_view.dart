// File: lib/src/features/habits/presentation/views/add_habit_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/application/providers/habit_reminders_controller_provider.dart';
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
import 'package:zentry/src/shared/domain/entities/habit.dart';

class AddHabitView extends ConsumerStatefulWidget {
  const AddHabitView({super.key});
  static const routeName = '/add-habit';

  @override
  ConsumerState<AddHabitView> createState() => _AddHabitViewState();
}

class _AddHabitViewState extends ConsumerState<AddHabitView> {
  final TextEditingController _nameCtrl = TextEditingController();

  // enums
  HabitFrequency _frequency = HabitFrequency.daily;
  HabitGoalType _goalType = HabitGoalType.reachAmount;
  HabitGoalUnit _goalUnit = HabitGoalUnit.times;
  HabitGoalPeriod _goalPeriod = HabitGoalPeriod.perDay;
  HabitGoalRecordMode _goalRecordMode = HabitGoalRecordMode.auto;
  HabitStatus _status = HabitStatus.active;

  // fields
  final Set<Weekday> _selectedDays = {};
  int? _targetAmount;
  DateTime? _startDate;
  DateTime? _endDate;
  final List<TimeOfDay> _reminders = [];

  // sectionId selected (String)
  String _selectedSectionId = 'anytime';

  // main sections (always present in dropdown)
  static const List<String> _mainSectionIds = [
    'morning',
    'afternoon',
    'evening',
    'anytime',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            _buildTextField('Habit Name', _nameCtrl),
            const SizedBox(height: 16),

            _buildDropdown<HabitFrequency>(
              'Frequency',
              _frequency,
              HabitFrequency.values,
              (val) => setState(() => _frequency = val),
            ),
            if (_frequency == HabitFrequency.weekly) _buildWeekdaySelector(),
            const SizedBox(height: 16),

            _buildDropdown<HabitGoalType>(
              'Goal Type',
              _goalType,
              HabitGoalType.values,
              (val) => setState(() => _goalType = val),
            ),
            _buildDropdown<HabitGoalUnit>(
              'Goal Unit',
              _goalUnit,
              HabitGoalUnit.values,
              (val) => setState(() => _goalUnit = val),
            ),
            _buildDropdown<HabitGoalPeriod>(
              'Goal Period',
              _goalPeriod,
              HabitGoalPeriod.values,
              (val) => setState(() => _goalPeriod = val),
            ),
            _buildDropdown<HabitGoalRecordMode>(
              'Record Mode',
              _goalRecordMode,
              HabitGoalRecordMode.values,
              (val) => setState(() => _goalRecordMode = val),
            ),

            const SizedBox(height: 16),
            _buildNumberField('Target Amount', (val) {
              _targetAmount = int.tryParse(val);
            }),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildDateButton(
                    context: context,
                    label: _startDate == null
                        ? 'Start date'
                        : 'Start: ${_startDate!.toLocal().toString().split(' ').first}',
                    onPick: (d) => setState(() => _startDate = d),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildDateButton(
                    context: context,
                    label: _endDate == null
                        ? 'End date (optional)'
                        : 'End: ${_endDate!.toLocal().toString().split(' ').first}',
                    onPick: (d) => setState(() => _endDate = d),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ===== SECTION DROPDOWN (main + user sections from DB) =====
            FutureBuilder<List<String>>(
              future: ref
                  .read(habitsControllerProvider.notifier)
                  .getAllSections()
                  .then((list) => list.map((s) => s.id).toList())
                  .catchError((_) => <String>[]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: CircularProgressIndicator(),
                  );
                }

                final userIds = snapshot.data ?? const <String>[];
                final allIds = [
                  ..._mainSectionIds,
                  ...userIds.where((id) => !_mainSectionIds.contains(id)),
                ];

                return DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Section',
                    border: OutlineInputBorder(),
                  ),
                  value: allIds.contains(_selectedSectionId)
                      ? _selectedSectionId
                      : 'anytime',
                  items: allIds
                      .map((id) => DropdownMenuItem<String>(
                            value: id,
                            child: Text(id),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedSectionId = val);
                    }
                  },
                );
              },
            ),

            const SizedBox(height: 16),
            _buildDropdown<HabitStatus>(
              'Status',
              _status,
              HabitStatus.values,
              (val) => setState(() => _status = val),
            ),

            const SizedBox(height: 16),
            _buildRemindersSection(),
          ],
        ),
      ),
    );
  }

  // ---------------- UI HELPERS ----------------
  Widget _buildTextField(String label, TextEditingController ctrl) {
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDropdown<T>(
    String label,
    T value,
    List<T> values,
    void Function(T) onChanged,
  ) {
    return DropdownButtonFormField<T>(
      decoration:
          InputDecoration(labelText: label, border: const OutlineInputBorder()),
      value: value,
      items: values
          .map((v) => DropdownMenuItem<T>(
                value: v,
                child: Text(v.toString().split('.').last),
              ))
          .toList(),
      onChanged: (v) => v != null ? onChanged(v) : null,
    );
  }

  Widget _buildDateButton({
    required BuildContext context,
    required String label,
    required void Function(DateTime) onPick,
  }) {
    return OutlinedButton.icon(
      onPressed: () async {
        final base = _startDate ?? DateTime.now();
        final picked = await showDatePicker(
          context: context,
          firstDate: DateTime(base.year - 2),
          lastDate: DateTime(base.year + 5),
          initialDate: base,
        );
        if (picked != null) onPick(picked);
      },
      icon: const Icon(Icons.event),
      label: Text(label),
    );
  }

  Widget _buildWeekdaySelector() {
    return Wrap(
      spacing: 8,
      children: Weekday.values.map((day) {
        final selected = _selectedDays.contains(day);
        return ChoiceChip(
          label: Text(day.toString().split('.').last.substring(0, 3)),
          selected: selected,
          onSelected: (val) {
            setState(() {
              if (val) {
                _selectedDays.add(day);
              } else {
                _selectedDays.remove(day);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildNumberField(String label, Function(String) onChanged) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildRemindersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Reminders',
                style: TextStyle(fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.add_alarm),
              onPressed: _pickReminder,
            ),
          ],
        ),
        Wrap(
          spacing: 8,
          children: _reminders.map((time) {
            return Chip(
              label: Text(time.format(context)),
              onDeleted: () {
                setState(() => _reminders.remove(time));
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Future<void> _pickReminder() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _reminders.add(picked));
    }
  }

  // ---------------- SAVE ----------------
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
      sectionId: _selectedSectionId, // ✅ use selected section id
      status: _status,
      frequency: _frequency,
      weeklyDays: _frequency == HabitFrequency.weekly
          ? WeekdayMask.fromDays(_selectedDays)
          : null,
      intervalDays: _frequency == HabitFrequency.daily ? null : _targetAmount,
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

    await ref.read(habitsControllerProvider.notifier).add(habit);

    // save reminders
    for (final time in _reminders) {
      final minutes = time.hour * 60 + time.minute;
      final reminder = HabitReminder(
        id: '${habitId}_$minutes',
        habitId: habitId,
        minutesSinceMidnight: minutes,
        enabled: true,
      );
      await ref
          .read(habitRemindersControllerProvider.notifier)
          .addReminder(reminder);
    }

    if (mounted) Navigator.pop(context, true);
  }
}
