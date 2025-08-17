import 'package:flutter/material.dart';
import 'package:zentry/src/core/utils/app_images.dart';
import 'package:zentry/src/features/appearance/domain/enums/season.dart';

class SeasonsGrid extends StatelessWidget {
  final Season selectedSeason;
  final ValueChanged<Season> onSeasonSelected;

  const SeasonsGrid({
    super.key,
    required this.selectedSeason,
    required this.onSeasonSelected,
  });

  @override
  Widget build(BuildContext context) {
    final options = [
      {'season': Season.spring, 'image': AppImages.imagesSpring},
      {'season': Season.summer, 'image': AppImages.imagesSummer},
      {'season': Season.autumn, 'image': AppImages.imagesAutumn},
      {'season': Season.winter, 'image': AppImages.imagesWinter},
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      childAspectRatio: 1.2,
      children: options.map((opt) {
        final season = opt['season']! as Season;
        final image = opt['image']! as String;

        return GestureDetector(
          onTap: () => onSeasonSelected(season),
          child: SeasonOption(
            image: image,
            label: season.name[0].toUpperCase() + season.name.substring(1),
            hasBadge: selectedSeason == season,
          ),
        );
      }).toList(),
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
                child: Image.asset(image, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(label, style: Theme.of(context).textTheme.bodyLarge),
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
              child: const Icon(Icons.check, color: Colors.white, size: 20),
            ),
          ),
      ],
    );
  }
}
