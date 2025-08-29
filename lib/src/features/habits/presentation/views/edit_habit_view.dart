import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/features/habits/application/providers/habits_controller_provider.dart';
import 'package:zentry/src/features/habits/application/providers/habit_reminders_controller_provider.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_details.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_goal.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_reminder.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_frequency.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_goal_period.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_goal_record_mode.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_goal_type.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_goal_unit.dart';
import 'package:zentry/src/features/habits/domain/enums/section_type.dart';
import 'package:zentry/src/features/habits/domain/enums/weekday.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
import 'package:zentry/src/features/habits/domain/value_objects/weekday_mask.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/date_button.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/drop_down_widget.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/number_field.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/reminders_section.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/text_field_widget.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/week_days_selector.dart';

class EditHabitView extends ConsumerStatefulWidget {
  const EditHabitView({super.key, required this.habitDetails});
  static const routeName = '/edit-habit';

  final HabitDetails habitDetails;

  @override
  ConsumerState<EditHabitView> createState() => _EditHabitViewState();
}

class _EditHabitViewState extends ConsumerState<EditHabitView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descCtrl;

  late HabitFrequency _frequency;
  late HabitGoalType _goalType;
  late HabitGoalUnit _goalUnit;
  late HabitGoalPeriod _goalPeriod;
  late HabitGoalRecordMode _goalRecordMode;
  late SectionType _sectionType;
  late HabitStatus _status;

  final Set<Weekday> _selectedDays = {};
  int? _targetAmount;
  int? _intervalDays;
  DateTime? _startDate;
  DateTime? _endDate;
  final List<TimeOfDay> _reminders = [];

  @override
  void initState() {
    super.initState();
    final h = widget.habitDetails.habit;
    _nameCtrl = TextEditingController(text: h.title);
    _descCtrl = TextEditingController(text: h.description ?? '');

    _frequency = h.frequency;
    _goalType = h.goal.type;
    _goalUnit = h.goal.unit;
    _goalPeriod = h.goal.period;
    _goalRecordMode = h.goal.recordMode;
    _sectionType = SectionType.values.firstWhere((e) => e.name == h.sectionId,
        orElse: () => SectionType.anytime);
    _status = h.status;

    if (h.weeklyDays != null) _selectedDays.addAll(h.weeklyDays!.days);
    _targetAmount = h.goal.targetAmount;
    _intervalDays = h.intervalDays;
    _startDate = h.goal.startDate;
    _endDate = h.goal.endDate;

    // load reminders from DB
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final actualReminders = await ref
          .read(habitRemindersControllerProvider.notifier)
          .getReminders(h.id);
      setState(() {
        _reminders.clear();
        _reminders.addAll(actualReminders.map((r) {
          final hh = r.minutesSinceMidnight ~/ 60;
          final mm = r.minutesSinceMidnight % 60;
          return TimeOfDay(hour: hh, minute: mm);
        }));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = ref.watch(appPaletteProvider);
    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        title: const Text('Edit Habit'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _confirmDelete,
            tooltip: 'Delete',
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveHabit,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldWidget(
                  controller: _nameCtrl,
                  label: 'Habit Name',
                  requiredField: true),
              const SizedBox(height: 12),
              TextFieldWidget(
                  controller: _descCtrl, label: 'Description (optional)'),
              const SizedBox(height: 12),
              DropdownWidget<SectionType>(
                  label: 'Section',
                  value: _sectionType,
                  items: SectionType.values,
                  onChanged: (v) => setState(() => _sectionType = v)),
              const SizedBox(height: 12),
              DropdownWidget<HabitStatus>(
                  label: 'Status',
                  value: _status,
                  items: HabitStatus.values,
                  onChanged: (v) => setState(() => _status = v)),
              const SizedBox(height: 12),
              DropdownWidget<HabitFrequency>(
                  label: 'Frequency',
                  value: _frequency,
                  items: HabitFrequency.values,
                  onChanged: (v) => setState(() => _frequency = v)),
              if (_frequency == HabitFrequency.weekly) ...[
                const SizedBox(height: 8),
                WeekdaySelector(
                  selectedDays: _selectedDays,
                  onChanged: (newSet) => setState(() {
                    _selectedDays.clear();
                    _selectedDays.addAll(newSet);
                  }),
                ),
              ],
              if (_frequency != HabitFrequency.daily &&
                  _frequency != HabitFrequency.weekly) ...[
                const SizedBox(height: 12),
                NumberField(
                  label: 'Interval (days)',
                  initial: _intervalDays?.toString() ?? '',
                  onChanged: (val) => _intervalDays = int.tryParse(val),
                ),
              ],
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DateButton(
                        label: _startDate == null
                            ? 'Start date'
                            : 'Start: ${_startDate!.toLocal().toString().split(' ').first}',
                        initialDate: _startDate,
                        onPick: (d) => setState(() => _startDate = d)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DateButton(
                        label: _endDate == null
                            ? 'End date (optional)'
                            : 'End: ${_endDate!.toLocal().toString().split(' ').first}',
                        initialDate: _endDate,
                        onPick: (d) => setState(() => _endDate = d)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownWidget<HabitGoalType>(
                  label: 'Goal type',
                  value: _goalType,
                  items: HabitGoalType.values,
                  onChanged: (v) => setState(() => _goalType = v)),
              const SizedBox(height: 12),
              DropdownWidget<HabitGoalUnit>(
                  label: 'Goal unit',
                  value: _goalUnit,
                  items: HabitGoalUnit.values,
                  onChanged: (v) => setState(() => _goalUnit = v)),
              const SizedBox(height: 12),
              DropdownWidget<HabitGoalPeriod>(
                  label: 'Goal period',
                  value: _goalPeriod,
                  items: HabitGoalPeriod.values,
                  onChanged: (v) => setState(() => _goalPeriod = v)),
              const SizedBox(height: 12),
              DropdownWidget<HabitGoalRecordMode>(
                  label: 'Record mode',
                  value: _goalRecordMode,
                  items: HabitGoalRecordMode.values,
                  onChanged: (v) => setState(() => _goalRecordMode = v)),
              const SizedBox(height: 12),
              NumberField(
                  label: 'Target amount',
                  initial: _targetAmount?.toString() ?? '',
                  onChanged: (val) => _targetAmount = int.tryParse(val)),
              const SizedBox(height: 24),
              RemindersSection(
                reminders: _reminders,
                onPickReminder: (time) => setState(() => _reminders.add(time)),
                onRemoveReminder: (time) =>
                    setState(() => _reminders.remove(time)),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _saveHabit,
                icon: const Icon(Icons.check),
                label: const Text('Save changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveHabit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_frequency == HabitFrequency.weekly && _selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pick at least one weekday')));
      return;
    }

    final old = widget.habitDetails.habit;
    final updated = old.copyWith(
      title: _nameCtrl.text.trim(),
      description: _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
      sectionId: _sectionType.name,
      status: _status,
      frequency: _frequency,
      weeklyDays: _frequency == HabitFrequency.weekly
          ? WeekdayMask.fromDays(_selectedDays)
          : null,
      intervalDays: (_frequency != HabitFrequency.daily &&
              _frequency != HabitFrequency.weekly)
          ? _intervalDays
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
      updatedAt: DateTime.now(),
    );

    final habitsCtrl = ref.read(habitsControllerProvider.notifier);
    await habitsCtrl.update(updated);
    await habitsCtrl.setTodayStatus(updated.id, _status);

    final reminderCtrl = ref.read(habitRemindersControllerProvider.notifier);
    await reminderCtrl.clearForHabit(updated.id);
    for (final time in _reminders) {
      final minutes = time.hour * 60 + time.minute;
      final reminder = HabitReminder(
        id: '${updated.id}_$minutes',
        habitId: updated.id,
        minutesSinceMidnight: minutes,
        enabled: true,
      );
      await reminderCtrl.addReminder(reminder);
    }

    if (mounted) Navigator.pop(context, true);
  }

  void _confirmDelete() async {
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
      ref
          .read(habitsControllerProvider.notifier)
          .delete(widget.habitDetails.habit.id);
      if (mounted) Navigator.pop(context, true);
    }
  }
}
