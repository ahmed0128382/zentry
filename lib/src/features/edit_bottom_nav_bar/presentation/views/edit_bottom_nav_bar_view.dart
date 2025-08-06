import 'package:flutter/material.dart';

class EditBottomNavBarView extends StatelessWidget {
  const EditBottomNavBarView({super.key});
  static const String routeName = '/edit-bottom-nav-bar';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Bar'),
      ),
      body: const Center(
        child: Text('Edit Bottom Nav Bar'),
      ),
    );
  }
}
