import 'package:flutter/material.dart';
import 'package:zentry/src/features/main/presentation/views/widgets/main_view_body.dart';

class MainView extends StatelessWidget {
  const MainView({super.key, required this.child, required this.location});

  static const routeName = '/main';

  final Widget child;
  final String location;

  @override
  Widget build(BuildContext context) {
    return MainViewBody(
      location: location,
      child: child,
    );
  }
}
