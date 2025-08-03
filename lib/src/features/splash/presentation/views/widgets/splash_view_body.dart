import 'package:flutter/material.dart';
import 'package:zentry/src/core/utils/app_colors.dart';
import 'package:zentry/src/core/utils/app_images.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightBackground,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppImages.logo, width: 120),
            const SizedBox(height: 24),
            const Text(
              'Welcome to Zentry',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
