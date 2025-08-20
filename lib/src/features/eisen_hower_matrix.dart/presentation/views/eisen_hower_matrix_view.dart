import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/application/providers/eisenhower_matrix_controller_provider.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/presentation/views/widgets/eisenhower_matrix_view_body.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/presentation/views/widgets/add_task_bottom_sheet.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/presentation/views/widgets/overlay_dismiss.dart';

class EisenHowerMatrixView extends ConsumerStatefulWidget {
  const EisenHowerMatrixView({super.key});

  @override
  ConsumerState<EisenHowerMatrixView> createState() =>
      _EisenHowerMatrixViewState();
}

class _EisenHowerMatrixViewState extends ConsumerState<EisenHowerMatrixView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = ref.watch(appPaletteProvider);
    final showSheet = ref.watch(eisenhowerMatrixControllerProvider);
    final controller = ref.read(eisenhowerMatrixControllerProvider.notifier);

    // Sync controller with animation
    controller.animationController = _animationController;

    return Scaffold(
      backgroundColor: palette.background,
      body: Stack(
        children: [
          const EisenhowerMatrixViewBody(),
          if (showSheet) const OverlayDismiss(),
          if (showSheet)
            SlideTransition(
              position: _offsetAnimation,
              child: AddTaskBottomSheet(
                titleFocusNode: controller.titleFocusNode,
                descriptionFocusNode: controller.descriptionFocusNode,
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: palette.secondary,
        heroTag: 'add_task_eisenhower',
        onPressed: () => controller.openSheet(vsync: this),
        child: Icon(
          Icons.add,
          color: palette.icon,
        ),
      ),
    );
  }
}
