import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/routes/router.dart';

import 'package:zentry/src/core/theme/app_theme.dart';
import 'package:zentry/src/core/utils/app_images.dart';

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

// class NtiApp extends StatelessWidget {
//   const NtiApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nti App',
//       theme: ThemeData(
//         brightness: Brightness.light,
//         primaryColor: Colors.blue,
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Nti Home'),
//           shadowColor: Colors.blue,
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               const Icon(Icons.home),
//               Text('Home Page'),
//               const SizedBox(height: 20),
//               Image.asset(AppImages.profileImage),
//               const SizedBox(height: 20),
//               Image.asset(AppImages.profileImage),
//               const SizedBox(height: 20),
//               Image.asset(AppImages.profileImage),
//               const SizedBox(height: 20),
//               Image.asset(AppImages.profileImage),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
