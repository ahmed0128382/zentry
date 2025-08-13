import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/routes/router.dart';

import 'package:zentry/src/core/theme/app_theme.dart';

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

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:zentry/src/core/utils/app_images.dart';

// void main() {
//   runApp(const NtiApp());
// }

// class NtiApp extends StatelessWidget {
//   const NtiApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Profile(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class Profile extends StatelessWidget {
//   const Profile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           //mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(right: 18.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(width: 20),
//                   Text('My Profile',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       )),
//                   SvgPicture.asset(AppImages.imagesSettings)
//                 ],
//               ),
//             ),
//             const SizedBox(height: 50),
//             CircleAvatar(
//               radius: 50,
//               backgroundImage: AssetImage('assets/images/profile_image.png'),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Sophia Carter',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               '@sophiac',
//               style: TextStyle(fontSize: 16, color: Color(0xff9C704A)),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Edit Pro..',
//               style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w900),
//             ),
//             const SizedBox(height: 10),
//             const Boxes(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Boxes extends StatelessWidget {
//   const Boxes({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         const SizedBox(width: 8),
//         Box(dataNo: '12', dataTitle: 'Box'),
//         const SizedBox(width: 20),
//         Box(dataNo: '3', dataTitle: 'Watch'),
//         const SizedBox(width: 20),
//         Box(dataNo: '5', dataTitle: 'Cart Items')
//       ],
//     );
//   }
// }

// class Box extends StatelessWidget {
//   const Box({super.key, required this.dataNo, required this.dataTitle});
//   final String dataNo;
//   final String dataTitle;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       height: 100,
//       decoration: ShapeDecoration(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//           side: BorderSide(color: Color(0xffE8D9CF), width: 1),
//         ),
//         shadows: [
//           // BoxShadow(
//           //   color: Colors.grey.withOpacity(0.2),
//           //   spreadRadius: 1,
//           //   blurRadius: 5,
//           //   offset: const Offset(0, 3), // changes position of shadow
//           // ),
//         ],
//       ),
//       child: Center(
//         child: Column(
//           children: [
//             const SizedBox(height: 28),
//             Text(
//               dataNo,
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(dataTitle,
//                 style: TextStyle(
//                     color: Color(0xff9C704A),
//                     fontSize: 16,
//                     fontWeight: FontWeight.w300)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class List extends StatelessWidget {
//   const List({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [],
//     );
//   }
// }

// class ListItem extends StatelessWidget {
//   const ListItem({super.key, required this.image, required this.title});
//   final String image;
//   final String title;
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
// class CounterApp extends StatefulWidget {
//   const CounterApp({super.key});

//   @override
//   State<CounterApp> createState() => _CounterAppState();
// }

// class _CounterAppState extends State<CounterApp> {
//   int counter = 0;

//   void increment() {
//     setState(() {
//       counter++;
//     });
//   }

//   void decrement() {
//     setState(() {
//       counter--;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Counter App with StatefulWidget'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Styled Text displaying the counter
//             Text(
//               '$counter',
//               style: const TextStyle(
//                 fontSize: 48,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blueAccent,
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Row with decrement and increment buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: decrement,
//                   child: const Text(
//                     '-',
//                     style: TextStyle(fontSize: 32),
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: increment,
//                   child: const Text(
//                     '+',
//                     style: TextStyle(fontSize: 32),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: increment,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
