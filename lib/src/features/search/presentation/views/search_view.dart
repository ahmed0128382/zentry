import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/core/utils/app_images.dart';
import 'package:flutter/services.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(appPaletteProvider);
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: palette.background,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search',
                style: TextStyle(
                  color: palette.icon,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                onTapOutside: (PointerDownEvent event) {
                  // Dismiss the keyboard when tapping outside the text field.
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search tasks, tags, lists and filters',
                  hintStyle:
                      TextStyle(color: palette.icon.withValues(alpha: 0.6)),
                  filled: true,
                  fillColor: palette.accent.withValues(alpha: 0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 20.0,
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Placeholder for the binoculars image.
                    // You would use an Image.asset or Image.network here
                    // if you had the image file.
                    SvgPicture.asset(
                      AppImages.imagesSearchLogo,
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      'What do you want to search',
                      style: TextStyle(
                        color: palette.icon,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Tap the input box to search',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: palette.icon.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Provider that loads & recolors the SVG string based on [Color]
final recoloredSvgProvider =
    FutureProvider.family<String, Color>((ref, color) async {
  String rawSvg = await rootBundle.loadString(AppImages.imagesSearchLogo);

  // Regex to match hex colors in the SVG
  final colorRegex = RegExp(r'#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})');

  // Replace all matched colors with target color
  final hex = '#${color.value.toRadixString(16).substring(2)}';
  rawSvg = rawSvg.replaceAllMapped(colorRegex, (_) => hex);

  return rawSvg;
});
