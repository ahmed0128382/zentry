import 'package:flutter/material.dart';
import 'package:zentry/src/core/utils/app_images.dart';

class SeasonsGrid extends StatelessWidget {
  const SeasonsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      childAspectRatio: 1.2,
      children: [
        SeasonOption(
          image: AppImages.imagesSpring, // Replace with your image asset path
          label: 'Spring',
          hasBadge: true,
        ),
        SeasonOption(
          image: AppImages.imagesWinter, // Replace with your image asset path
          label: 'winter',
        ),
      ],
    );
  }
}

class SeasonOption extends StatelessWidget {
  final String image;
  final String label;
  final bool hasBadge;

  const SeasonOption({
    super.key,
    required this.image,
    required this.label,
    this.hasBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        if (hasBadge)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(
                Icons.star,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
      ],
    );
  }
}
