import 'package:flutter/material.dart';

class BadgeItem extends StatelessWidget {
  final String label;

  const BadgeItem({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.yellow.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.yellow, width: 2),
          ),
          child: const Icon(Icons.star, color: Colors.yellow, size: 30),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: Text(label, style: const TextStyle(fontSize: 12)),
        ),
      ],
    );
  }
}
