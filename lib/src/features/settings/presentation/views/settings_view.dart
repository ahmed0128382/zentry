import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/features/appearance/presentation/views/them_settings_view.dart';
import 'package:zentry/src/features/edit_bottom_nav_bar/presentation/views/edit_bottom_nav_bar_view.dart';
import 'package:zentry/src/features/main/application/providers/more_menu_type_provider.dart';
import 'package:zentry/src/features/profile/presentation/views/profile_view.dart';
import 'package:zentry/src/features/settings/presentation/views/widgets/settings_header.dart';
import 'package:zentry/src/features/settings/presentation/views/widgets/settings_integration_section.dart';
import 'package:zentry/src/features/settings/presentation/views/widgets/settings_premium_section.dart';
import 'package:zentry/src/features/settings/presentation/views/widgets/settings_section.dart';
import 'package:zentry/src/features/settings/presentation/views/widgets/settings_user_profile.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(appPaletteProvider);
    final selectedType = ref.watch(moreMenuTypeProvider);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingsHeader(),
            SettingsUserProfile(onTap: () {
              context.push(ProfileView.routeName);
            }),
            const SizedBox(height: 20),
            const SettingsPremiumAccountSection(),
            const SizedBox(height: 20),
            SettingsSection(
              selectedType: selectedType,
              onMoreMenuTypeChanged: (newType) {
                if (newType != null) {
                  ref.read(moreMenuTypeProvider.notifier).state = newType;
                }
              },
              onEditTabBarTap: () {
                context.push(EditBottomNavBarView.routeName);
              },
              onAppearanceTap: () {
                context.push(ThemeSettingsView.routeName);
              },
            ),
            const SizedBox(height: 20),
            const SettingsIntegrationSection(),
          ],
        ),
      ),
    );
  }
}
