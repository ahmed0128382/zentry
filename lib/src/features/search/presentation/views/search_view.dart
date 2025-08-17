import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/core/utils/app_images.dart';

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
                    Image.asset(
                      AppImages.searchLogo,
                      colorBlendMode:
                          BlendMode.modulate, // Replace with your image path
                      height: 150,
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
