import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/routes/router.dart';

import 'package:zentry/src/core/theme/app_theme.dart';
import 'package:zentry/src/core/utils/app_colors.dart';
import 'package:zentry/src/core/utils/app_fonts.dart';
import 'package:zentry/src/features/appearance/application/providers/appearance_controller_provider.dart';
import 'package:zentry/src/shared/enums/app_theme_mode.dart';

///remake the heirarchy to be apply to satisfy this beside Clean architecture + DDD and RiverPod with Drift but maybe i switch drift later and use something else so keep it clean with with SOLID principles///

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: أي تهيئة مبكرة مثل Hive أو Drift أو SharedPreferences

  runApp(
    const ProviderScope(child: ZentryApp()),
  );
}

class ZentryApp extends ConsumerWidget {
  const ZentryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final appearanceState = ref.watch(appearanceControllerProvider);
    final seedColor = appearanceState?.seedColor != null
        ? Color(appearanceState!.seedColor)
        : AppColors.peacefulSeaBlue;
    final textScale = appearanceState?.textScale ?? 1.0;
    final fontFamily = appearanceState?.fontFamily ?? AppFonts.primaryFont;

    return MaterialApp.router(
      title: 'Zentry',
      debugShowCheckedModeBanner: false,
      themeMode:
          _mapThemeMode(appearanceState?.themeMode ?? AppThemeMode.system),
      theme: buildTheme(Brightness.light, seedColor, textScale, fontFamily,
          AppTheme.lightTheme),
      darkTheme: buildTheme(Brightness.dark, seedColor, textScale, fontFamily,
          AppTheme.darkTheme),
      routerConfig: router,
    );
  }

  ThemeMode _mapThemeMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
      default:
        return ThemeMode.system;
    }
  }

  ThemeData buildTheme(Brightness brightness, Color seedColor, double textScale,
      String fontFamily, ThemeData baseTheme) {
    return baseTheme.copyWith(
      colorScheme:
          ColorScheme.fromSeed(seedColor: seedColor, brightness: brightness),
      textTheme: baseTheme.textTheme
          .apply(fontSizeFactor: textScale, fontFamily: fontFamily),
    );
  }
}
