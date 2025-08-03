import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zentry/src/core/utils/app_colors.dart';
import 'package:zentry/src/core/utils/app_styles.dart';
import 'package:zentry/src/features/on_boarding/presentation/views/on_boarding_view.dart/widgets/on_boarding_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final Animation<double> _logoScale;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _logoScale = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutBack,
    );

    _logoController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      context.go(OnBoardingView.routeName);
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkBackground,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: ScaleTransition(
          scale: _logoScale,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ✅ Logo
              Image.asset(
                'assets/icons/splash_logo.png',
                height: 120,
                width: 120,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 24),

              // ✅ Tagline
              Text(
                "Productivity. Rewarded.",
                style: AppStyles.splashTagline,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
