import 'package:flutter/material.dart';
import 'package:zentry/src/features/appearance/presentation/views/theme_settings_view_body.dart';

class ThemeSettingsView extends StatelessWidget {
  const ThemeSettingsView({super.key});
  static const String routeName = '/themSettings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Theme Settings'),
      // ),
      body: const ThemeSettingsViewBody(),
    );
  }
}
