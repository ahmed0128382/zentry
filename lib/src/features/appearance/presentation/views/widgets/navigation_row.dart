// import 'package:flutter/material.dart';

// class NavigationRow extends StatelessWidget {
//   final String title;
//   final String value;

//   const NavigationRow({
//     super.key,
//     required this.title,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(title, style: textTheme.bodyLarge),
//         Row(
//           children: [
//             Text(
//               value,
//               style: textTheme.bodyLarge?.copyWith(color: Colors.grey),
//             ),
//             const Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.grey),
//           ],
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';

class NavigationRow extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onTap;

  const NavigationRow({
    super.key,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textTheme.bodyLarge),
          Row(
            children: [
              Text(
                value,
                style: textTheme.bodyLarge?.copyWith(color: Colors.grey),
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 16.0, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
