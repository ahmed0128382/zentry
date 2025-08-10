import 'package:flutter/material.dart';
import 'package:zentry/src/core/widgets/custom_card.dart';
import 'package:zentry/src/features/settings/presentation/views/widgets/settings_item.dart';

class SettingsIntegrationSection extends StatelessWidget {
  const SettingsIntegrationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          SettingsItem(
            icon: Icons.share,
            title: 'Import & Integration',
            color: Colors.green,
          ),
          const Divider(),
          SettingsItem(
            icon: Icons.handshake,
            title: 'Recommend to Friends',
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}
