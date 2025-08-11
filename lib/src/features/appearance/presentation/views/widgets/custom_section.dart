import 'package:flutter/material.dart';

class CustomSection extends StatelessWidget {
  final String title;
  final Widget child;

  const CustomSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textTheme.titleLarge),
        const SizedBox(height: 16.0),
        child,
      ],
    );
  }
}
