import 'package:flutter/material.dart';
import 'package:zentry/src/core/utils/app_images.dart';
import 'package:zentry/src/core/widgets/custom_card.dart';
import 'package:zentry/src/core/widgets/custom_tag.dart';

class SettingsUserProfile extends StatelessWidget {
  final VoidCallback onTap;

  const SettingsUserProfile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomCard(
        child: Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 30,
                  backgroundImage: AssetImage(AppImages.profileImage),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child:
                        const Icon(Icons.star, color: Colors.orange, size: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'أحمد إبراهيم أبوموسي',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      CustomTag(
                        color: Colors.green,
                        icon: Icons.trending_up,
                        label: 'Lv.1',
                      ),
                      const SizedBox(width: 8),
                      CustomTag(
                        color: Colors.purple,
                        icon: Icons.star_border,
                        label: '6 Badges',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
