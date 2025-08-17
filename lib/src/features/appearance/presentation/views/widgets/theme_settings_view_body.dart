import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/appearance/application/providers/appearance_controller_provider.dart';
import 'package:zentry/src/features/appearance/domain/enums/season.dart';
import 'package:zentry/src/features/appearance/presentation/views/widgets/color_grid.dart';
import 'package:zentry/src/features/appearance/presentation/views/widgets/custom_section.dart';
import 'package:zentry/src/features/appearance/presentation/views/widgets/navigation_row.dart';
import 'package:zentry/src/features/appearance/presentation/views/widgets/season_grid.dart';
import 'package:zentry/src/features/appearance/presentation/views/widgets/toggle_row.dart';
import 'package:zentry/src/shared/enums/app_theme_mode.dart';

class ThemeSettingsViewBody extends ConsumerWidget {
  const ThemeSettingsViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appearanceControllerProvider);

    final themeMode = settings?.themeMode ?? AppThemeMode.system;
    final seedColor = settings?.seedColor ?? 0xFF2196F3; // Use int
    final season = settings?.season ?? Season.spring; // Use Season enum

    // If settings are null, show a loader
    if (settings == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggle for system theme
            ToggleRow(
              label: 'Go with the system dark mode',
              value: themeMode == AppThemeMode.system,
              onChanged: (useSystem) {
                ref.read(appearanceControllerProvider.notifier).updateTheme(
                      useSystem ? AppThemeMode.system : AppThemeMode.light,
                    );
              },
            ),
            const SizedBox(height: 16.0),

            // Preferred night theme
            NavigationRow(
              title: 'Preferred Night Theme',
              value: themeMode == AppThemeMode.dark ? "Dark" : "Light",
              onTap: () {
                ref.read(appearanceControllerProvider.notifier).updateTheme(
                      themeMode == AppThemeMode.dark
                          ? AppThemeMode.light
                          : AppThemeMode.dark,
                    );
              },
            ),

            const Divider(height: 32.0),

            // Color Series
            CustomSection(
              title: 'Color Series',
              child: ColorGrid(
                selectedColor: seedColor,
                onColorSelected: (color) {
                  ref
                      .read(appearanceControllerProvider.notifier)
                      .updateSeedColor(color);
                },
              ),
            ),

            const Divider(height: 32.0),

            // Seasons Series
            CustomSection(
              title: 'Seasons Series',
              child: SeasonsGrid(
                selectedSeason: season,
                onSeasonSelected: (selectedSeason) {
                  ref
                      .read(appearanceControllerProvider.notifier)
                      .updateSeason(selectedSeason);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
