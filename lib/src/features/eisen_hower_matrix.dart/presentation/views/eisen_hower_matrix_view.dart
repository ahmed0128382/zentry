import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/presentation/views/widgets/eisenhower_matrix_view_body.dart';

class EisenHowerMatrixView extends ConsumerWidget {
  const EisenHowerMatrixView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(appPaletteProvider);
    return Scaffold(
      backgroundColor: palette.background,
      body: EisenhowerMatrixViewBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: palette.primary,
        child: Icon(Icons.add, color: palette.text),
        onPressed: () {},
      ),
    );
  }
}
