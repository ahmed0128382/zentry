import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/utils/app_colors.dart';
import 'package:zentry/src/features/appearance/application/providers/appearance_controller_provider.dart';
import 'package:zentry/src/features/appearance/presentation/views/widgets/theme_settings_view_body.dart';

class ThemeSettingsView extends ConsumerWidget {
  const ThemeSettingsView({super.key});
  static const String routeName = '/theme-settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appearance = ref.watch(appearanceControllerProvider);
    AppColors.updateFromAppearance(appearance);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Theme Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: ThemeSettingsViewBody(),
    );
  }
}
