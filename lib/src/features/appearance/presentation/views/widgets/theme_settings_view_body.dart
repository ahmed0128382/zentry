import 'package:flutter/material.dart';
import 'package:zentry/src/features/appearance/presentation/views/widgets/color_grid.dart';
import 'package:zentry/src/features/appearance/presentation/views/widgets/custom_section.dart';
import 'package:zentry/src/features/appearance/presentation/views/widgets/navigation_row.dart';
import 'package:zentry/src/features/appearance/presentation/views/widgets/season_grid.dart';
import 'package:zentry/src/features/appearance/presentation/views/widgets/toggle_row.dart';

class ThemeSettingsViewBody extends StatelessWidget {
  const ThemeSettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToggleRow(
              label: 'Go with the system dark mode',
              value: true,
              onChanged: (_) {},
            ),
            const SizedBox(height: 16.0),
            NavigationRow(
              title: 'Preferred Night Theme',
              value: 'Dark Blue',
            ),
            const Divider(height: 32.0),
            CustomSection(
              title: 'Color Series',
              child: const ColorGrid(),
            ),
            const Divider(height: 32.0),
            CustomSection(
              title: 'Seasons Series',
              child: const SeasonsGrid(),
            ),
          ],
        ),
      ),
    );
  }
}
