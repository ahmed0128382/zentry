import 'package:flutter/material.dart';
import 'package:zentry/src/features/edit_bottom_nav_bar/presentation/views/widgets/edit_bottom_nav_bar_item.dart';

class EditBottomNavBarView extends StatelessWidget {
  const EditBottomNavBarView({super.key});
  static const String routeName = '/edit-bottom-nav-bar';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Bar'),
      ),
      body: const TabBarSettingsPage(),
    );
  }
}
