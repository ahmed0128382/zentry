import 'package:flutter/material.dart';

class ThemeSettingsViewBody extends StatelessWidget {
  const ThemeSettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Go with the system dark mode',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Switch(
                  value: true, // This should be a state variable
                  onChanged: (value) {},
                  activeColor: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Preferred Night Theme',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Row(
                  children: [
                    Text(
                      'Dark Blue',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 32.0),
            Text(
              'Color Series',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            const ColorGrid(),
            const Divider(height: 32.0),
            Text(
              'Seasons Series',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            const SeasonsGrid(),
          ],
        ),
      ),
    );
  }
}

class ColorGrid extends StatelessWidget {
  const ColorGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      children: const [
        ColorOption(color: Colors.blue, label: 'Default', isSelected: true),
        ColorOption(color: Colors.cyan, label: 'Teal'),
        ColorOption(color: Colors.greenAccent, label: 'Turquoise'),
        ColorOption(color: Colors.lightGreen, label: 'Matcha'),
        ColorOption(color: Colors.amber, label: 'Sunshine'),
        ColorOption(color: Colors.pinkAccent, label: 'Peach'),
        ColorOption(color: Colors.purpleAccent, label: 'Lilac'),
        ColorOption(color: Colors.white, label: 'Pearl', hasBadge: true),
        ColorOption(color: Colors.grey, label: 'Pebble'),
        ColorOption(color: Colors.black, label: 'Dark\nOrange', hasBadge: true),
        ColorOption(
            color: Colors.blueAccent, label: 'Material You', hasBadge: true),
      ],
    );
  }
}

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
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 24,
                      ),
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
                  child: const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

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
          image:
              'assets/images/spring.png', // Replace with your image asset path
          label: 'Spring',
          hasBadge: true,
        ),
        SeasonOption(
          image:
              'assets/images/summer.png', // Replace with your image asset path
          label: 'Summer',
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
