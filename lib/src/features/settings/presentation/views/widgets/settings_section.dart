import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/core/widgets/custom_card.dart';
import 'package:zentry/src/features/settings/presentation/views/widgets/settings_item.dart';
import 'package:zentry/src/shared/enums/menu_types.dart';

class SettingsSection extends ConsumerWidget {
  final MoreMenuType selectedType;
  final ValueChanged<MoreMenuType?> onMoreMenuTypeChanged;
  final VoidCallback onEditTabBarTap;
  final VoidCallback onAppearanceTap;

  const SettingsSection({
    super.key,
    required this.selectedType,
    required this.onMoreMenuTypeChanged,
    required this.onEditTabBarTap,
    required this.onAppearanceTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(appPaletteProvider);
    return CustomCard(
      child: Column(
        children: [
          SettingsItem(
            icon: Icons.widgets,
            title: 'Tab Bar',
            onTap: onEditTabBarTap,
          ),
          const Divider(),
          SettingsItem(
            icon: Icons.menu,
            title: '',
            trailing: DropdownButtonHideUnderline(
              child: DropdownButton<MoreMenuType>(
                dropdownColor:
                    palette.primary.withValues(alpha: 0.2), // menu background
                iconEnabledColor: palette.primary, // arrow icon color
                value: selectedType,
                onChanged: onMoreMenuTypeChanged,
                items: MoreMenuType.values
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(
                            type.name,
                            style: TextStyle(
                                color: palette.icon.withValues(alpha: 0.8)),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          const Divider(),
          SettingsItem(
              icon: Icons.palette, title: 'Appearance', onTap: onAppearanceTap),
          const Divider(),
          SettingsItem(icon: Icons.access_time, title: 'Date & Time'),
          const Divider(),
          SettingsItem(icon: Icons.music_note, title: 'Sounds & Notifications'),
          const Divider(),
          SettingsItem(icon: Icons.grid_view, title: 'Widgets'),
          const Divider(),
          SettingsItem(icon: Icons.list, title: 'General'),
        ],
      ),
    );
  }
}
