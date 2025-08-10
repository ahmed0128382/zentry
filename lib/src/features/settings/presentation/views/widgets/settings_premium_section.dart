import 'package:flutter/material.dart';
import 'package:zentry/src/core/widgets/custom_card.dart';

class SettingsPremiumAccountSection extends StatelessWidget {
  const SettingsPremiumAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Row(
        children: [
          const Icon(Icons.workspace_premium, color: Colors.orange, size: 24),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Premium Account',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 4),
                Text('Calendar view and more fun...',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.orange,
              backgroundColor: Colors.orange.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Colors.orange),
              ),
              elevation: 0,
            ),
            child: const Text('UPGRADE NOW'),
          ),
        ],
      ),
    );
  }
}
