import 'package:flutter/material.dart';
import 'package:zentry/src/features/habits/presentation/views/widgets/calender_header.dart';

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
