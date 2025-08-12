import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/to_do_today/application/providers/to_do_today_controller_provider.dart';

class OverlayDismiss extends ConsumerWidget {
  const OverlayDismiss({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () =>
            ref.read(toDoTodayControllerProvider.notifier).closeSheet(),
        child: Container(color: Colors.black54),
      ),
    );
  }
}
