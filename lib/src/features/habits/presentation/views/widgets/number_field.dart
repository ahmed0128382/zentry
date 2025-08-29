import 'package:flutter/material.dart';

class NumberField extends StatelessWidget {
  final String label;
  final String? initial;
  final Function(String) onChanged;

  const NumberField({
    super.key,
    required this.label,
    required this.onChanged,
    this.initial,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initial,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
