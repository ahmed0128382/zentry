import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:zentry/src/features/splash/presentation/views/splash_view.dart';

// import باقي الشاشات لما نجهزها مثل onboarding، home، tasks... إلخ

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: SplashView.splashRouteName,
    routes: [
      GoRoute(
        path: SplashView.splashRouteName,
        builder: (context, state) => const SplashView(),
      ),
      // GoRoute(
      //   path: OnboardingView.routePath,
      //   builder: (context, state) => const OnboardingView(),
      // ),
      // GoRoute(...), وهكذا لبقية الشاشات
    ],
  );
});
