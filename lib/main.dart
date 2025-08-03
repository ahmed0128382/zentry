import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/routes/router.dart';

import 'package:zentry/src/core/theme/app_theme.dart';

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

    return MaterialApp.router(
      title: 'Zentry',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // الثيم العام
      routerConfig: router,
    );
  }
}
