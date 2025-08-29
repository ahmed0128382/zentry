import 'package:flutter/material.dart';

class NumberField extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  const NumberField({super.key, required this.label, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration:
          InputDecoration(labelText: label, border: const OutlineInputBorder()),
      onChanged: onChanged,
    );
  }
}
