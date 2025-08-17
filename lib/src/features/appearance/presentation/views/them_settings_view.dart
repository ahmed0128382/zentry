import 'package:flutter/material.dart';
import 'package:zentry/src/core/utils/app_colors.dart';
import 'package:zentry/src/features/appearance/presentation/views/widgets/theme_settings_view_body.dart';

class ThemeSettingsView extends StatelessWidget {
  const ThemeSettingsView({super.key});
  static const String routeName = '/theme-settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
        centerTitle: true,
        backgroundColor: AppColors.peacefulSeaBlue,
      ),
      body: ThemeSettingsViewBody(),
    );
  }
}
