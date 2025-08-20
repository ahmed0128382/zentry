import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/application/providers/eisenhower_matrix_controller_provider.dart';

class OverlayDismiss extends ConsumerWidget {
  const OverlayDismiss({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () =>
            ref.read(eisenhowerMatrixControllerProvider.notifier).closeSheet(),
        child: Container(color: Colors.black54),
      ),
    );
  }
}
