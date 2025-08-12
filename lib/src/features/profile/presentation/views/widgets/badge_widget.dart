import 'package:flutter/material.dart';
import 'package:zentry/src/features/profile/presentation/views/widgets/badge_item.dart';

class BadgesWidget extends StatelessWidget {
  const BadgesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          BadgeItem(label: '3'),
          BadgeItem(label: '2'),
          BadgeItem(label: '2'),
          BadgeItem(label: '2'),
          BadgeItem(label: '1'),
          BadgeItem(label: '1'),
        ],
      ),
    );
  }
}
