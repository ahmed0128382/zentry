import 'package:flutter/material.dart';

class CompletedHeader extends StatelessWidget {
  const CompletedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SizedBox(width: 8.0),
        Text(
          'COMPLETED',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Spacer(),
        Row(
          children: [
            Text(
              '5',
              style: TextStyle(color: Colors.grey),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          ],
        ),
      ],
    );
  }
}
