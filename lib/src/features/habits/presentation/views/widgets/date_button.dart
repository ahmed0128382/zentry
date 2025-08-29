import 'package:flutter/material.dart';

class DateButton extends StatelessWidget {
  final String label;
  final DateTime? initialDate;
  final void Function(DateTime) onPick;
  const DateButton(
      {super.key, required this.label, this.initialDate, required this.onPick});
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.event),
      label: Text(label),
      onPressed: () async {
        final base = initialDate ?? DateTime.now();
        final picked = await showDatePicker(
          context: context,
          firstDate: DateTime(base.year - 2),
          lastDate: DateTime(base.year + 5),
          initialDate: base,
        );
        if (picked != null) onPick(picked);
      },
    );
  }
}
