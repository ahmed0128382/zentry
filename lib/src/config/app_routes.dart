/// Centralized list of all named routes used in the app.
/// Helps maintain consistency and avoid typos.
abstract class AppRoutes {
  static const today = '/today';
  static const calendar = '/calendar';
  static const matrix = '/matrix';
  static const focus = '/Focus';
  static const search = '/search';
  static const habits = '/habits';
  static const countdown = '/countdown';
  static const settings = '/settings';
  static const profile = '/profile';

  /// List of all route names.
  static List<String> get all => [
        today,
        calendar,
        matrix,
        focus,
        search,
        habits,
        countdown,
        settings,
        profile,
      ];
}
