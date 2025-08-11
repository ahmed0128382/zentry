import 'package:flutter/material.dart';

class ColorOption extends StatelessWidget {
  final Color color;
  final String label;
  final bool isSelected;
  final bool hasBadge;

  const ColorOption({
    super.key,
    required this.color,
    required this.label,
    this.isSelected = false,
    this.hasBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  width: 3.0,
                ),
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(Icons.check_circle,
                          color: Colors.white, size: 24),
                    )
                  : null,
            ),
            if (hasBadge)
              Positioned(
                top: -5,
                right: -5,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.star, color: Colors.white, size: 16),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8.0),
        Flexible(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
