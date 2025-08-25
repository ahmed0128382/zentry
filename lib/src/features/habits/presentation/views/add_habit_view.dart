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

// class AddHabitView extends ConsumerStatefulWidget {
//   const AddHabitView({super.key});
//   static const routeName = '/add-habit';

//   @override
//   ConsumerState<AddHabitView> createState() => _AddHabitViewState();
// }

// class _AddHabitViewState extends ConsumerState<AddHabitView> {
//   // Basic state
//   final TextEditingController _nameCtrl = TextEditingController();

//   // Enums
//   HabitFrequency _frequency = HabitFrequency.daily;
//   HabitGoalType _goalType = HabitGoalType.reachAmount;
//   HabitGoalUnit _goalUnit = HabitGoalUnit.times;
//   HabitGoalPeriod _goalPeriod = HabitGoalPeriod.perDay;
//   HabitGoalRecordMode _goalRecordMode = HabitGoalRecordMode.auto;
//   SectionType _sectionType = SectionType.anytime;
//   HabitStatus _status = HabitStatus.active;

//   // Other fields
//   final Set<Weekday> _selectedDays = {};
//   int? _targetAmount;
//   DateTime? _startDate;
//   DateTime? _endDate;
//   final List<TimeOfDay> _reminders = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Habit'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.check),
//             onPressed: _saveHabit,
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _buildTextField('Habit Name', _nameCtrl),
//             const SizedBox(height: 16),
//             _buildDropdown<HabitFrequency>(
//               'Frequency',
//               _frequency,
//               HabitFrequency.values,
//               (val) => setState(() => _frequency = val),
//             ),
//             if (_frequency == HabitFrequency.weekly) _buildWeekdaySelector(),
//             const SizedBox(height: 16),
//             _buildDropdown<HabitGoalType>(
//               'Goal Type',
//               _goalType,
//               HabitGoalType.values,
//               (val) => setState(() => _goalType = val),
//             ),
//             _buildDropdown<HabitGoalUnit>(
//               'Goal Unit',
//               _goalUnit,
//               HabitGoalUnit.values,
//               (val) => setState(() => _goalUnit = val),
//             ),
//             _buildDropdown<HabitGoalPeriod>(
//               'Goal Period',
//               _goalPeriod,
//               HabitGoalPeriod.values,
//               (val) => setState(() => _goalPeriod = val),
//             ),
//             _buildDropdown<HabitGoalRecordMode>(
//               'Record Mode',
//               _goalRecordMode,
//               HabitGoalRecordMode.values,
//               (val) => setState(() => _goalRecordMode = val),
//             ),
//             const SizedBox(height: 16),
//             _buildNumberField('Target Amount', (val) {
//               _targetAmount = int.tryParse(val);
//             }),
//             const SizedBox(height: 16),
//             _buildDatePicker('Start Date', _startDate, (d) {
//               setState(() => _startDate = d);
//             }),
//             _buildDatePicker('End Date', _endDate, (d) {
//               setState(() => _endDate = d);
//             }),
//             const SizedBox(height: 16),
//             _buildDropdown<SectionType>(
//               'Section',
//               _sectionType,
//               SectionType.values,
//               (val) => setState(() => _sectionType = val),
//             ),
//             const SizedBox(height: 16),
//             _buildDropdown<HabitStatus>(
//               'Status',
//               _status,
//               HabitStatus.values,
//               (val) => setState(() => _status = val),
//             ),
//             const SizedBox(height: 24),
//             _buildReminders(),
//           ],
//         ),
//       ),
//     );
//   }

//   // ------------------- UI HELPERS -------------------

//   Widget _buildTextField(String label, TextEditingController ctrl) {
//     return TextField(
//       controller: ctrl,
//       decoration: InputDecoration(
//         labelText: label,
//         border: const OutlineInputBorder(),
//       ),
//     );
//   }

//   Widget _buildDropdown<T>(
//     String label,
//     T value,
//     List<T> values,
//     void Function(T) onChanged,
//   ) {
//     return DropdownButtonFormField<T>(
//       decoration:
//           InputDecoration(labelText: label, border: const OutlineInputBorder()),
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

//   Widget _buildNumberField(String label, Function(String) onChanged) {
//     return TextField(
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         labelText: label,
//         border: const OutlineInputBorder(),
//       ),
//       onChanged: onChanged,
//     );
//   }

//   Widget _buildDatePicker(
//       String label, DateTime? date, Function(DateTime) onPicked) {
//     return ListTile(
//       title: Text(
//           date == null ? label : '$label: ${date.toLocal()}'.split(' ')[0]),
//       trailing: const Icon(Icons.calendar_today),
//       onTap: () async {
//         final picked = await showDatePicker(
//           context: context,
//           initialDate: date ?? DateTime.now(),
//           firstDate: DateTime(2000),
//           lastDate: DateTime(2100),
//         );
//         if (picked != null) {
//           setState(() => label = '$label: ${picked.toLocal()}'.split(' ')[0]);
//           onPicked(picked);
//         }
//       },
//     );
//   }

//   Widget _buildReminders() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Reminders', style: TextStyle(fontWeight: FontWeight.bold)),
//         Wrap(
//           spacing: 8,
//           children: _reminders.map((t) {
//             return Chip(
//               label: Text(t.format(context)),
//               onDeleted: () {
//                 setState(() => _reminders.remove(t));
//               },
//             );
//           }).toList(),
//         ),
//         TextButton.icon(
//           onPressed: () async {
//             final picked = await showTimePicker(
//               context: context,
//               initialTime: const TimeOfDay(hour: 9, minute: 0),
//             );
//             if (picked != null) {
//               setState(() => _reminders.add(picked));
//             }
//           },
//           icon: const Icon(Icons.add),
//           label: const Text('Add Reminder'),
//         ),
//       ],
//     );
//   }

//   // ------------------- SAVE -------------------
//   void _saveHabit() async {
//     final name = _nameCtrl.text.trim();
//     if (name.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter a habit name')),
//       );
//       return;
//     }

//     final habit = Habit(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       title: name,
//       description: null, // or use another text field if you have one
//       sectionId: _sectionType.name, // Map SectionType enum -> String id
//       status: _status,
//       frequency: _frequency,
//       weeklyDays: _frequency == HabitFrequency.weekly
//           ? WeekdayMask.fromDays(_selectedDays)
//           : null,
//       intervalDays: _frequency == HabitFrequency.daily ? null : _targetAmount,
//       goal: HabitGoal(
//         type: _goalType,
//         unit: _goalUnit,
//         period: _goalPeriod,
//         recordMode: _goalRecordMode,
//         targetAmount: _targetAmount,
//         startDate: _startDate,
//         endDate: _endDate,
//       ),
//       createdAt: DateTime.now(),
//       updatedAt: DateTime.now(),
//     );

//     await ref.read(habitsControllerProvider.notifier).add(habit);

//     if (mounted) Navigator.pop(context);
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/application/providers/habits_controller_provider.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_goal.dart';
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
  SectionType _sectionType = SectionType.anytime;
  HabitStatus _status = HabitStatus.active;

  final Set<Weekday> _selectedDays = {};
  int? _targetAmount;
  DateTime? _startDate;
  DateTime? _endDate;
  final List<TimeOfDay> _reminders = []; // reserved for later

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
            _buildNumberField('Target Amount', (val) {
              _targetAmount = int.tryParse(val);
            }),
          ],
        ),
      ),
    );
  }

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

  void _saveHabit() {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a habit name')),
      );
      return;
    }

    final now = DateTime.now();

    final habit = Habit(
      id: now.millisecondsSinceEpoch.toString(),
      title: name,
      description: null,
      sectionId: _sectionType.name, // keep as enum name for now
      status: _status,
      frequency: _frequency,
      weeklyDays: _frequency == HabitFrequency.weekly
          ? WeekdayMask.fromDays(_selectedDays)
          : null,
      // for quick test, reuse targetAmount as interval if not daily
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

    // ✅ use controller.add(...)
    ref.read(habitsControllerProvider.notifier).add(habit);

    if (mounted) Navigator.pop(context, true);
  }
}
