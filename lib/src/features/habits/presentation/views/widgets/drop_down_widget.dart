import 'package:flutter/material.dart';

class DropdownWidget<T> extends StatelessWidget {
  final String label;
  final T value;
  final List<T> items;
  final Function(T) onChanged;

  const DropdownWidget({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      value: value,
      items: items
          .map((v) => DropdownMenuItem(
                value: v,
                child: Text(v.toString().split('.').last),
              ))
          .toList(),
      onChanged: (v) => v != null ? onChanged(v) : null,
    );
  }
}
