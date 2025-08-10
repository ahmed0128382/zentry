import 'package:flutter/material.dart';
import 'package:zentry/src/core/widgets/custom_card.dart';
import 'package:zentry/src/features/settings/presentation/views/widgets/settings_item.dart';
import 'package:zentry/src/shared/enums/menu_types.dart';

class SettingsSection extends StatelessWidget {
  final MoreMenuType selectedType;
  final ValueChanged<MoreMenuType?> onMoreMenuTypeChanged;
  final VoidCallback onEditTabBarTap;

  const SettingsSection({
    super.key,
    required this.selectedType,
    required this.onMoreMenuTypeChanged,
    required this.onEditTabBarTap,
  });

  @override
  Widget build(BuildContext context) {
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
                value: selectedType,
                onChanged: onMoreMenuTypeChanged,
                items: MoreMenuType.values
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type.name),
                        ))
                    .toList(),
              ),
            ),
          ),
          const Divider(),
          SettingsItem(icon: Icons.palette, title: 'Appearance'),
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
