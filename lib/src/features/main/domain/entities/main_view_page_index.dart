import 'package:zentry/src/config/app_routes.dart';
import 'package:zentry/src/shared/enums/main_view_pages_index.dart';

extension MainViewPageIndexExtension on MainViewPageIndex {
  /// Returns the route string associated with the enum value.
  String get route {
    switch (this) {
      case MainViewPageIndex.toDoToday:
        return AppRoutes.today;
      case MainViewPageIndex.calendar:
        return AppRoutes.calendar;
      case MainViewPageIndex.eisenhowerMatrix:
        return AppRoutes.matrix;
      case MainViewPageIndex.focus:
        return AppRoutes.focus;
      case MainViewPageIndex.search:
        return AppRoutes.search;
      case MainViewPageIndex.habits:
        return AppRoutes.habits;
      case MainViewPageIndex.countdown:
        return AppRoutes.countdown;
      case MainViewPageIndex.settings:
        return AppRoutes.settings;
      case MainViewPageIndex.profile:
        return AppRoutes.profile;
    }
  }

  /// Converts a route string to the corresponding enum value.
  /// Returns [toDoToday] as default if no matching route is found.
  static MainViewPageIndex fromRoute(String? location) {
    if (location == null || location.isEmpty) {
      return MainViewPageIndex.toDoToday;
    }

    return MainViewPageIndex.values.firstWhere(
      (page) => location.startsWith(page.route),
      orElse: () => MainViewPageIndex.toDoToday,
    );
  }
}
