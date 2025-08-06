import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zentry/src/features/edit_bottom_nav_bar/presentation/views/edit_bottom_nav_bar_view.dart';
import 'package:zentry/src/features/main/presentation/views/widgets/settings_menu_type_dropdown.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SettingsMenuTypeDropdown(),
        SizedBox(height: 20),
        ElevatedButton.icon(
            onPressed: () {
              context.push(EditBottomNavBarView.routeName);
            },
            icon: Icon(Icons.edit),
            label: Text('Edit Bar')),
      ],
    );
  }
}
