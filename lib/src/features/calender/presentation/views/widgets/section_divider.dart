// Divider with padding
import 'package:flutter/material.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Divider(
        height: 1,
        color: Colors.grey,
        indent: 16,
        endIndent: 16,
      ),
    );
  }
}
