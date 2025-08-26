// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:zentry/src/features/habits/application/providers/habits_controller_provider.dart';
// import 'package:zentry/src/features/habits/domain/entities/habit_goal.dart';
// import 'package:zentry/src/features/habits/domain/enums/habit_frequency.dart';
// import 'package:zentry/src/features/habits/domain/enums/habit_goal_period.dart';
// import 'package:zentry/src/features/habits/domain/enums/habit_goal_record_mode.dart';
// import 'package:zentry/src/features/habits/domain/enums/habit_goal_type.dart';
// import 'package:zentry/src/features/habits/domain/enums/habit_goal_unit.dart';
// import 'package:zentry/src/features/habits/domain/enums/section_type.dart';
// import 'package:zentry/src/features/habits/domain/enums/weekday.dart';
// import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
// import 'package:zentry/src/features/habits/domain/value_objects/weekday_mask.dart';
// import 'package:zentry/src/shared/domain/entities/habit.dart';

// class EditHabitView extends ConsumerStatefulWidget {
//   const EditHabitView({super.key, required this.habit});
//   static const routeName = '/edit-habit';

//   final Habit habit;

//   @override
//   ConsumerState<EditHabitView> createState() => _EditHabitViewState();
// }

// class _EditHabitViewState extends ConsumerState<EditHabitView> {
//   final _formKey = GlobalKey<FormState>();
//   late final TextEditingController _nameCtrl;
//   late final TextEditingController _descCtrl;

//   late HabitFrequency _frequency;
//   late HabitGoalType _goalType;
//   late HabitGoalUnit _goalUnit;
//   late HabitGoalPeriod _goalPeriod;
//   late HabitGoalRecordMode _goalRecordMode;
//   late SectionType _sectionType;
//   late HabitStatus _status;

//   final Set<Weekday> _selectedDays = {};
//   int? _targetAmount;
//   int? _intervalDays;
//   DateTime? _startDate;
//   DateTime? _endDate;

//   @override
//   void initState() {
//     super.initState();
//     final h = widget.habit;
//     _nameCtrl = TextEditingController(text: h.title);
//     _descCtrl = TextEditingController(text: h.description ?? '');

//     _frequency = h.frequency;
//     _goalType = h.goal.type;
//     _goalUnit = h.goal.unit;
//     _goalPeriod = h.goal.period;
//     _goalRecordMode = h.goal.recordMode;
//     _sectionType = SectionType.values.firstWhere((e) => e.name == h.sectionId,
//         orElse: () => SectionType.anytime);
//     _status = h.status;

//     if (h.weeklyDays != null) {
//       _selectedDays.addAll(h.weeklyDays!.days);
//     }
//     _targetAmount = h.goal.targetAmount;
//     _intervalDays = h.intervalDays;
//     _startDate = h.goal.startDate;
//     _endDate = h.goal.endDate;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Habit'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.delete_outline),
//             onPressed: _confirmDelete,
//             tooltip: 'Delete',
//           ),
//           IconButton(
//             icon: const Icon(Icons.check),
//             onPressed: _saveHabit,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               _buildTextField('Habit Name', _nameCtrl, requiredField: true),
//               const SizedBox(height: 12),
//               _buildTextField('Description (optional)', _descCtrl),
//               const SizedBox(height: 12),
//               _buildDropdown<SectionType>(
//                 'Section',
//                 _sectionType,
//                 SectionType.values,
//                 (v) => setState(() => _sectionType = v),
//               ),
//               const SizedBox(height: 12),
//               _buildDropdown<HabitStatus>(
//                 'Status',
//                 _status,
//                 HabitStatus.values,
//                 (v) => setState(() => _status = v),
//               ),
//               const SizedBox(height: 12),
//               _buildDropdown<HabitFrequency>(
//                 'Frequency',
//                 _frequency,
//                 HabitFrequency.values,
//                 (v) => setState(() => _frequency = v),
//               ),
//               if (_frequency == HabitFrequency.weekly) ...[
//                 const SizedBox(height: 8),
//                 _buildWeekdaySelector(),
//               ],
//               if (_frequency != HabitFrequency.daily &&
//                   _frequency != HabitFrequency.weekly) ...[
//                 const SizedBox(height: 12),
//                 _buildNumberField(
//                   'Interval (days)',
//                   (val) => _intervalDays = int.tryParse(val),
//                   initial: _intervalDays?.toString() ?? '',
//                   validator: (val) {
//                     if (val == null || val.trim().isEmpty) return 'Required';
//                     final n = int.tryParse(val);
//                     if (n == null || n <= 0) return 'Enter a positive number';
//                     return null;
//                   },
//                 ),
//               ],
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildDateButton(
//                       context: context,
//                       label: _startDate == null
//                           ? 'Start date'
//                           : 'Start: ${_startDate!.toLocal().toString().split(' ').first}',
//                       onPick: (d) => setState(() => _startDate = d),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: _buildDateButton(
//                       context: context,
//                       label: _endDate == null
//                           ? 'End date (optional)'
//                           : 'End: ${_endDate!.toLocal().toString().split(' ').first}',
//                       onPick: (d) => setState(() => _endDate = d),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               _buildDropdown<HabitGoalType>(
//                 'Goal type',
//                 _goalType,
//                 HabitGoalType.values,
//                 (v) => setState(() => _goalType = v),
//               ),
//               const SizedBox(height: 12),
//               _buildDropdown<HabitGoalUnit>(
//                 'Goal unit',
//                 _goalUnit,
//                 HabitGoalUnit.values,
//                 (v) => setState(() => _goalUnit = v),
//               ),
//               const SizedBox(height: 12),
//               _buildDropdown<HabitGoalPeriod>(
//                 'Goal period',
//                 _goalPeriod,
//                 HabitGoalPeriod.values,
//                 (v) => setState(() => _goalPeriod = v),
//               ),
//               const SizedBox(height: 12),
//               _buildDropdown<HabitGoalRecordMode>(
//                 'Record mode',
//                 _goalRecordMode,
//                 HabitGoalRecordMode.values,
//                 (v) => setState(() => _goalRecordMode = v),
//               ),
//               const SizedBox(height: 12),
//               _buildNumberField(
//                 'Target amount',
//                 (val) => _targetAmount = int.tryParse(val),
//                 initial: _targetAmount?.toString() ?? '',
//               ),
//               const SizedBox(height: 24),
//               FilledButton.icon(
//                 onPressed: _saveHabit,
//                 icon: const Icon(Icons.check),
//                 label: const Text('Save changes'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController ctrl,
//       {bool requiredField = false}) {
//     return TextFormField(
//       controller: ctrl,
//       decoration: InputDecoration(
//         labelText: label,
//         border: const OutlineInputBorder(),
//       ),
//       validator: requiredField
//           ? (v) => (v == null || v.trim().isEmpty) ? 'Required' : null
//           : null,
//     );
//   }

//   Widget _buildDropdown<T>(
//     String label,
//     T value,
//     List<T> values,
//     void Function(T) onChanged,
//   ) {
//     return DropdownButtonFormField<T>(
//       decoration: InputDecoration(
//         labelText: label,
//         border: const OutlineInputBorder(),
//       ),
//       value: value,
//       items: values
//           .map((v) => DropdownMenuItem<T>(
//                 value: v,
//                 child: Text(v.toString().split('.').last),
//               ))
//           .toList(),
//       onChanged: (v) => v != null ? onChanged(v) : null,
//     );
//   }

//   Widget _buildWeekdaySelector() {
//     return Wrap(
//       spacing: 8,
//       children: Weekday.values.map((day) {
//         final selected = _selectedDays.contains(day);
//         return ChoiceChip(
//           label: Text(day.toString().split('.').last.substring(0, 3)),
//           selected: selected,
//           onSelected: (val) {
//             setState(() {
//               if (val) {
//                 _selectedDays.add(day);
//               } else {
//                 _selectedDays.remove(day);
//               }
//             });
//           },
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildNumberField(
//     String label,
//     Function(String) onChanged, {
//     String? initial,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       initialValue: initial,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         labelText: label,
//         border: const OutlineInputBorder(),
//       ),
//       onChanged: onChanged,
//       validator: validator,
//     );
//   }

//   Widget _buildDateButton({
//     required BuildContext context,
//     required String label,
//     required void Function(DateTime) onPick,
//   }) {
//     return OutlinedButton.icon(
//       onPressed: () async {
//         final base = _startDate ?? DateTime.now();
//         final picked = await showDatePicker(
//           context: context,
//           firstDate: DateTime(base.year - 2),
//           lastDate: DateTime(base.year + 5),
//           initialDate: base,
//         );
//         if (picked != null) onPick(picked);
//       },
//       icon: const Icon(Icons.event),
//       label: Text(label),
//     );
//   }

//   void _saveHabit() {
//     if (!_formKey.currentState!.validate()) return;
//     if (_frequency == HabitFrequency.weekly && _selectedDays.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Pick at least one weekday')),
//       );
//       return;
//     }

//     final old = widget.habit;
//     final updated = old.copyWith(
//       title: _nameCtrl.text.trim(),
//       description: _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
//       sectionId: _sectionType.name,
//       status: _status,
//       frequency: _frequency,
//       weeklyDays: _frequency == HabitFrequency.weekly
//           ? WeekdayMask.fromDays(_selectedDays)
//           : null,
//       intervalDays: (_frequency != HabitFrequency.daily &&
//               _frequency != HabitFrequency.weekly)
//           ? _intervalDays
//           : null,
//       goal: HabitGoal(
//         type: _goalType,
//         unit: _goalUnit,
//         period: _goalPeriod,
//         recordMode: _goalRecordMode,
//         targetAmount: _targetAmount,
//         startDate: _startDate,
//         endDate: _endDate,
//       ),
//       updatedAt: DateTime.now(),
//     );

//     ref.read(habitsControllerProvider.notifier).update(updated);
//     if (mounted) Navigator.pop(context, true);
//   }

//   void _confirmDelete() async {
//     final ok = await showDialog<bool>(
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
//     if (ok == true) {
//       ref.read(habitsControllerProvider.notifier).delete(widget.habit.id);
//       if (mounted) Navigator.pop(context, true);
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/application/providers/habits_controller_provider.dart';
import 'package:zentry/src/features/habits/application/providers/habit_reminders_controller_provider.dart';
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
import 'package:zentry/src/shared/domain/entities/habit.dart';

class EditHabitView extends ConsumerStatefulWidget {
  const EditHabitView({super.key, required this.habit});
  static const routeName = '/edit-habit';

  final Habit habit;

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
    final h = widget.habit;
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

    if (h.weeklyDays != null) {
      _selectedDays.addAll(h.weeklyDays!.days);
    }
    _targetAmount = h.goal.targetAmount;
    _intervalDays = h.intervalDays;
    _startDate = h.goal.startDate;
    _endDate = h.goal.endDate;

    // load reminders from DB
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final reminders = await ref
          .read(habitRemindersControllerProvider.notifier)
          .getReminders(h.id);
      setState(() {
        _reminders.clear();
        _reminders.addAll(reminders.map((r) {
          final h = r.minutesSinceMidnight ~/ 60;
          final m = r.minutesSinceMidnight % 60;
          return TimeOfDay(hour: h, minute: m);
        }));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _buildTextField('Habit Name', _nameCtrl, requiredField: true),
              const SizedBox(height: 12),
              _buildTextField('Description (optional)', _descCtrl),
              const SizedBox(height: 12),
              _buildDropdown<SectionType>(
                'Section',
                _sectionType,
                SectionType.values,
                (v) => setState(() => _sectionType = v),
              ),
              const SizedBox(height: 12),
              _buildDropdown<HabitStatus>(
                'Status',
                _status,
                HabitStatus.values,
                (v) => setState(() => _status = v),
              ),
              const SizedBox(height: 12),
              _buildDropdown<HabitFrequency>(
                'Frequency',
                _frequency,
                HabitFrequency.values,
                (v) => setState(() => _frequency = v),
              ),
              if (_frequency == HabitFrequency.weekly) ...[
                const SizedBox(height: 8),
                _buildWeekdaySelector(),
              ],
              if (_frequency != HabitFrequency.daily &&
                  _frequency != HabitFrequency.weekly) ...[
                const SizedBox(height: 12),
                _buildNumberField(
                  'Interval (days)',
                  (val) => _intervalDays = int.tryParse(val),
                  initial: _intervalDays?.toString() ?? '',
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) return 'Required';
                    final n = int.tryParse(val);
                    if (n == null || n <= 0) return 'Enter a positive number';
                    return null;
                  },
                ),
              ],
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
              _buildDropdown<HabitGoalType>(
                'Goal type',
                _goalType,
                HabitGoalType.values,
                (v) => setState(() => _goalType = v),
              ),
              const SizedBox(height: 12),
              _buildDropdown<HabitGoalUnit>(
                'Goal unit',
                _goalUnit,
                HabitGoalUnit.values,
                (v) => setState(() => _goalUnit = v),
              ),
              const SizedBox(height: 12),
              _buildDropdown<HabitGoalPeriod>(
                'Goal period',
                _goalPeriod,
                HabitGoalPeriod.values,
                (v) => setState(() => _goalPeriod = v),
              ),
              const SizedBox(height: 12),
              _buildDropdown<HabitGoalRecordMode>(
                'Record mode',
                _goalRecordMode,
                HabitGoalRecordMode.values,
                (v) => setState(() => _goalRecordMode = v),
              ),
              const SizedBox(height: 12),
              _buildNumberField(
                'Target amount',
                (val) => _targetAmount = int.tryParse(val),
                initial: _targetAmount?.toString() ?? '',
              ),
              const SizedBox(height: 24),
              _buildRemindersSection(),
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

  Widget _buildTextField(String label, TextEditingController ctrl,
      {bool requiredField = false}) {
    return TextFormField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: requiredField
          ? (v) => (v == null || v.trim().isEmpty) ? 'Required' : null
          : null,
    );
  }

  Widget _buildDropdown<T>(
    String label,
    T value,
    List<T> values,
    void Function(T) onChanged,
  ) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
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

  Widget _buildNumberField(
    String label,
    Function(String) onChanged, {
    String? initial,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      initialValue: initial,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
      validator: validator,
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
              onDeleted: () => setState(() => _reminders.remove(time)),
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

  // same helpers: _buildTextField, _buildDropdown, _buildWeekdaySelector,
  // _buildNumberField, _buildDateButton (unchanged)...

  void _saveHabit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_frequency == HabitFrequency.weekly && _selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick at least one weekday')),
      );
      return;
    }

    final old = widget.habit;
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

    await ref.read(habitsControllerProvider.notifier).update(updated);

    // replace reminders
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
      ref.read(habitsControllerProvider.notifier).delete(widget.habit.id);
      if (mounted) Navigator.pop(context, true);
    }
  }
}
