import 'package:flutter/material.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/add_section_view.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/more_overlay.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: const [
            Icon(Icons.menu, color: Colors.grey),
            SizedBox(width: 16.0),
            Text('Inbox'),
          ],
        ),
      ),
      actions: [
        MoreOverlay(
          options: [
            MoreOverlayOption(
              icon: Icons.settings,
              label: 'Settings',
              onTap: () {},
            ),
            MoreOverlayOption(
              icon: Icons.analytics,
              label: 'Analytics',
              onTap: () {},
            ),
            MoreOverlayOption(
              icon: Icons.archive,
              label: 'Archive',
              onTap: () {},
            ),
            MoreOverlayOption(
              icon: Icons.note_add,
              label: 'Add Section',
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AddSectionView())),
            ),
            MoreOverlayOption(
              icon: Icons.help_outline,
              label: 'Help',
              onTap: () {},
            ),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
