import 'package:flutter/material.dart';
import 'package:zentry/src/features/habits/domain/enums/section_type.dart';

/// Section Header as Widget
class SectionHeaderWidget extends StatelessWidget {
  final SectionType sectionType;

  const SectionHeaderWidget({super.key, required this.sectionType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(sectionType.icon, size: 18),
          const SizedBox(width: 6),
          Text(
            sectionType.displayName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
