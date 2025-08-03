import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zentry/src/features/on_boarding/presentation/views/on_boarding_view.dart';

import 'package:zentry/src/features/splash/presentation/views/splash_view.dart';

// import باقي الشاشات لما نجهزها مثل onboarding، home، tasks... إلخ

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: SplashView.routeName,
    routes: [
      GoRoute(
        path: SplashView.routeName,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: OnBoardingView.routeName,
        builder: (context, state) => const OnBoardingView(),
      ),
      // GoRoute(...), وهكذا لبقية الشاشات
    ],
  );
});
