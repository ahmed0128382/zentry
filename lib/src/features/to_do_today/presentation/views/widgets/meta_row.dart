import 'package:flutter/material.dart';

class MetaRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const MetaRow(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        );
    final valueStyle = Theme.of(context).textTheme.bodyLarge;

    return Row(
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 10),
        Text(label, style: labelStyle),
        const SizedBox(width: 12),
        Expanded(
            child: Text(value, style: valueStyle, textAlign: TextAlign.right)),
      ],
    );
  }
}
