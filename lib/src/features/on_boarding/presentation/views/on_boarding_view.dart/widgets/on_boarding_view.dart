import 'package:flutter/material.dart';
import 'package:zentry/src/features/on_boarding/presentation/views/on_boarding_view.dart/widgets/on_boarding_view_body.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});
  static const String routeName = '/onboarding';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const OnBoardingViewBody(),
    );
  }
}
