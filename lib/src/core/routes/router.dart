import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zentry/src/config/app_routes.dart';
import 'package:zentry/src/features/appearance/presentation/views/them_settings_view.dart';
import 'package:zentry/src/features/main/presentation/views/main_view.dart';
import 'package:zentry/src/features/main/presentation/views/widgets/main_view_pages.dart';
import 'package:zentry/src/features/profile/presentation/views/profile_view.dart';
import 'package:zentry/src/features/splash/presentation/views/splash_view.dart';
import 'package:zentry/src/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:zentry/src/features/edit_bottom_nav_bar/presentation/views/edit_bottom_nav_bar_view.dart';
import 'package:zentry/src/shared/enums/main_view_pages_index.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.today,
    routes: [
      // Splash
      GoRoute(
        path: SplashView.routeName,
        builder: (_, __) => const SplashView(),
      ),

      // Onboarding
      GoRoute(
        path: OnBoardingView.routeName,
        builder: (_, __) => const OnBoardingView(),
      ),

      // ShellRoute for main navigation
      ShellRoute(
        builder: (context, state, child) => MainView(
          location: state.uri.toString(),
          child: child,
        ),
        routes: [
          GoRoute(
            path: AppRoutes.today,
            builder: (_, __) => mainViewPagesMap[MainViewPageIndex.toDoToday]!,
          ),
          GoRoute(
            path: AppRoutes.calendar,
            builder: (_, __) => mainViewPagesMap[MainViewPageIndex.calendar]!,
          ),
          GoRoute(
            path: AppRoutes.matrix,
            builder: (_, __) =>
                mainViewPagesMap[MainViewPageIndex.eisenhowerMatrix]!,
          ),
          GoRoute(
            path: AppRoutes.focus,
            builder: (_, __) => mainViewPagesMap[MainViewPageIndex.focus]!,
          ),
          GoRoute(
            path: AppRoutes.search,
            builder: (_, __) => mainViewPagesMap[MainViewPageIndex.search]!,
          ),
          GoRoute(
            path: AppRoutes.habits,
            builder: (_, __) => mainViewPagesMap[MainViewPageIndex.habits]!,
          ),
          GoRoute(
            path: AppRoutes.countdown,
            builder: (_, __) => mainViewPagesMap[MainViewPageIndex.countdown]!,
          ),
          GoRoute(
            path: AppRoutes.settings,
            builder: (_, __) => mainViewPagesMap[MainViewPageIndex.settings]!,
          ),
        ],
      ),

      // Outside Shell — full-screen routes
      GoRoute(
        path: EditBottomNavBarView.routeName,
        builder: (_, __) => const EditBottomNavBarView(),
      ),
      GoRoute(
        path: ThemeSettingsView.routeName,
        builder: (_, __) => const ThemeSettingsView(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (_, __) => const ProfileView(),
      ),
    ],
    errorBuilder: (_, state) => const Scaffold(
      body: Center(child: Text('Page not found')),
    ),
  );
});
