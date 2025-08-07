// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:zentry/src/core/utils/app_images.dart';
// import 'package:zentry/src/features/edit_bottom_nav_bar/presentation/views/edit_bottom_nav_bar_view.dart';
// import 'package:zentry/src/features/main/presentation/controllers/main_navigation_controller.dart';
// import 'package:zentry/src/shared/enums/main_view_pages_Indexes.dart';
// import 'package:zentry/src/shared/enums/menu_types.dart';

// class SettingsView extends ConsumerWidget {
//   const SettingsView({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedType = ref.watch(moreMenuTypeProvider);
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           child: Column(
//             children: [
//               _buildHeader(context),
//               _buildUserProfile(context, ref),
//               SizedBox(height: 20),
//               _buildPremiumAccount(context),
//               SizedBox(height: 20),
//               _buildSettingsSection(context, ref, selectedType),
//               SizedBox(height: 20),
//               _buildIntegrationSection(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 8.0, left: 16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Profile',
//             style: const TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildUserProfile(BuildContext context, WidgetRef ref) {
//     return GestureDetector(
//       onTap: () {
//         ref
//             .read(mainNavProvider.notifier)
//             .updateIndex(MainViewPageIndex.profile.index);
//       },
//       child: Container(
//         padding: EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           color: Theme.of(context).cardColor,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Stack(
//               children: [
//                 CircleAvatar(
//                   backgroundColor: Colors.transparent,
//                   radius: 30,
//                   backgroundImage:
//                       AssetImage(AppImages.profileImage), // Placeholder image
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   child: Container(
//                     padding: EdgeInsets.all(2),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.star,
//                       color: Colors.orange,
//                       size: 16,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'أحمد إبراهيم أبوموسي',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Container(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Colors.green.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.trending_up,
//                               color: Colors.green,
//                               size: 16,
//                             ),
//                             SizedBox(width: 4),
//                             Text(
//                               'Lv.1',
//                               style: TextStyle(
//                                 color: Colors.green,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       Container(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.star_border,
//                               color: Colors.purple,
//                               size: 16,
//                             ),
//                             SizedBox(width: 4),
//                             Text(
//                               '6 Badges',
//                               style: TextStyle(
//                                 color: Colors.purple,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Icon(Icons.arrow_forward_ios, color: Colors.grey),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPremiumAccount(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Icon(
//             Icons.workspace_premium,
//             color: Colors.orange,
//             size: 24,
//           ),
//           SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Premium Account',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   'Calendar view and more fun...',
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               foregroundColor: Colors.orange,
//               backgroundColor: Colors.orange.withOpacity(0.1),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 side: BorderSide(color: Colors.orange),
//               ),
//               elevation: 0,
//             ),
//             child: Text('UPGRADE NOW'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSettingsSection(
//       BuildContext context, WidgetRef ref, MoreMenuType selectedType) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildSettingsItem(context, icon: Icons.widgets, title: 'Tab Bar',
//               onTap: () {
//             context.push(EditBottomNavBarView.routeName);
//           }),
//           const Divider(),
//           _buildSettingsItem(
//             context,
//             icon: Icons.menu,
//             title: '',
//             trailing: DropdownButtonHideUnderline(
//               child: DropdownButton<MoreMenuType>(
//                 value: selectedType,
//                 onChanged: (newType) {
//                   if (newType != null) {
//                     ref.read(moreMenuTypeProvider.notifier).state = newType;
//                   }
//                 },
//                 items: MoreMenuType.values.map((type) {
//                   return DropdownMenuItem(
//                     value: type,
//                     child: Text(type.name),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//           const Divider(),
//           _buildSettingsItem(context,
//               icon: Icons.palette, title: 'Appearance', onTap: () {}),
//           const Divider(),
//           _buildSettingsItem(context,
//               icon: Icons.access_time, title: 'Date & Time', onTap: () {}),
//           const Divider(),
//           _buildSettingsItem(context,
//               icon: Icons.music_note,
//               title: 'Sounds & Notifications',
//               onTap: () {}),
//           const Divider(),
//           _buildSettingsItem(context,
//               icon: Icons.grid_view, title: 'Widgets', onTap: () {}),
//           const Divider(),
//           _buildSettingsItem(context,
//               icon: Icons.list, title: 'General', onTap: () {}),
//         ],
//       ),
//     );
//   }

//   Widget _buildIntegrationSection(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildSettingsItem(
//             context,
//             icon: Icons.share,
//             title: 'Import & Integration',
//             color: Colors.green,
//             onTap: () {},
//           ),
//           const Divider(),
//           _buildSettingsItem(
//             context,
//             icon: Icons.handshake,
//             title: 'Recommend to Friends',
//             color: Colors.orange,
//             onTap: () {},
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSettingsItem(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     VoidCallback? onTap,
//     Color? color,
//     Widget? trailing,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: (color ?? Colors.blue).withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 icon,
//                 color: color ?? Colors.blue,
//                 size: 24,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Text(
//                 title,
//                 style:
//                     const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//               ),
//             ),
//             trailing ??
//                 const Icon(Icons.arrow_forward_ios,
//                     color: Colors.grey, size: 16),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zentry/src/core/utils/app_images.dart';
import 'package:zentry/src/features/edit_bottom_nav_bar/presentation/views/edit_bottom_nav_bar_view.dart';
import 'package:zentry/src/features/main/presentation/controllers/main_navigation_controller.dart';
import 'package:zentry/src/shared/enums/main_view_pages_Indexes.dart';
import 'package:zentry/src/shared/enums/menu_types.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType = ref.watch(moreMenuTypeProvider);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            _buildHeader(),
            _buildUserProfile(context, ref),
            const SizedBox(height: 20),
            _buildPremiumAccount(context),
            const SizedBox(height: 20),
            _buildSettingsSection(context, ref, selectedType),
            const SizedBox(height: 20),
            _buildIntegrationSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.only(right: 8.0, left: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref
            .read(mainNavProvider.notifier)
            .updateIndex(MainViewPageIndex.profile.index);
      },
      child: _buildCard(
        context,
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
                      _buildTag(
                        context,
                        color: Colors.green,
                        icon: Icons.trending_up,
                        label: 'Lv.1',
                      ),
                      const SizedBox(width: 8),
                      _buildTag(
                        context,
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

  Widget _buildPremiumAccount(BuildContext context) {
    return _buildCard(
      context,
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

  Widget _buildSettingsSection(
      BuildContext context, WidgetRef ref, MoreMenuType selectedType) {
    return _buildCard(
      context,
      child: Column(
        children: [
          _buildSettingsItem(context, icon: Icons.widgets, title: 'Tab Bar',
              onTap: () {
            context.push(EditBottomNavBarView.routeName);
          }),
          const Divider(),
          _buildSettingsItem(
            context,
            icon: Icons.menu,
            title: '',
            trailing: DropdownButtonHideUnderline(
              child: DropdownButton<MoreMenuType>(
                value: selectedType,
                onChanged: (newType) {
                  if (newType != null) {
                    ref.read(moreMenuTypeProvider.notifier).state = newType;
                  }
                },
                items: MoreMenuType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.name),
                  );
                }).toList(),
              ),
            ),
          ),
          const Divider(),
          _buildSettingsItem(context, icon: Icons.palette, title: 'Appearance'),
          const Divider(),
          _buildSettingsItem(context,
              icon: Icons.access_time, title: 'Date & Time'),
          const Divider(),
          _buildSettingsItem(context,
              icon: Icons.music_note, title: 'Sounds & Notifications'),
          const Divider(),
          _buildSettingsItem(context, icon: Icons.grid_view, title: 'Widgets'),
          const Divider(),
          _buildSettingsItem(context, icon: Icons.list, title: 'General'),
        ],
      ),
    );
  }

  Widget _buildIntegrationSection(BuildContext context) {
    return _buildCard(
      context,
      child: Column(
        children: [
          _buildSettingsItem(
            context,
            icon: Icons.share,
            title: 'Import & Integration',
            color: Colors.green,
          ),
          const Divider(),
          _buildSettingsItem(
            context,
            icon: Icons.handshake,
            title: 'Recommend to Friends',
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Color? color,
    Widget? trailing,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (color ?? Colors.blue).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color ?? Colors.blue, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
            ),
            trailing ??
                const Icon(Icons.arrow_forward_ios,
                    color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildTag(BuildContext context,
      {required Color color, required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
                color: color, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
