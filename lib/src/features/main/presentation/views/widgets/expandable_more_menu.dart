import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zentry/src/features/main/presentation/views/widgets/bottom_bar_item.dart';

class ExpandableMoreMenu extends StatefulWidget {
  const ExpandableMoreMenu(
      {super.key,
      required this.items,
      required this.onTap,
      required this.startIndex});
  final List<BottomBarItem> items;
  final Function(int index) onTap;
  final int startIndex;
  @override
  State<ExpandableMoreMenu> createState() => _ExpandableMoreMenuState();
}

class _ExpandableMoreMenuState extends State<ExpandableMoreMenu>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotation = Tween<double>(begin: 0, end: 0.5).animate(_controller);
  }

  void toggle() {
    setState(() {
      isExpanded = !isExpanded;
      isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Items appear in quarter circle
        if (isExpanded)
          ...List.generate(widget.items.length, (i) {
            final angle = (i + 1) * 30.0; // adjust spacing here
            final radians = angle * (3.14 / 180);

            return Positioned(
              bottom: 60 + 70 * sin(radians),
              right: 16 + 70 * cos(radians),
              child: FloatingActionButton(
                mini: true,
                heroTag: 'item_$i',
                onPressed: () {
                  toggle();
                  widget.onTap(widget.startIndex + i);
                },
                child: Icon(widget.items[i].icon, size: 20),
              ),
            );
          }),

        // Main toggle button
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            heroTag: 'main_toggle',
            onPressed: toggle,
            child: RotationTransition(
              turns: _rotation,
              child: const Icon(Icons.more_horiz),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
