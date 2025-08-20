import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EisenhowerMatrixController extends StateNotifier<bool> {
  EisenhowerMatrixController() : super(false);

  // Optional: store focus nodes here
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  // Controller for sliding animation (needs TickerProvider, so you can
  // pass it or manage differently)
  late AnimationController? animationController;

  void openSheet({required TickerProvider vsync}) {
    animationController ??= AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 250),
    );
    animationController!.forward();
    state = true;

    // Delay focus request until animation started
    Future.delayed(const Duration(milliseconds: 120), () {
      titleFocusNode.requestFocus();
    });
  }

  void closeSheet() {
    // Unfocus text fields when closing
    titleFocusNode.unfocus();
    descriptionFocusNode.unfocus();

    animationController?.reverse().then((_) {
      state = false;
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    titleFocusNode.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }
}
