import 'package:flutter/material.dart';

class EditableTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final TextStyle? style;
  final Function(String) onChanged;
  final int? minLines;
  final int? maxLines;

  const EditableTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hint,
    required this.onChanged,
    this.style,
    this.minLines,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveMaxLines = maxLines != null
        ? (minLines != null && maxLines! < minLines! ? minLines : maxLines)
        : null;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          style: style,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
              border: InputBorder.none),
          minLines: minLines ?? 1,
          maxLines: effectiveMaxLines ?? 1,
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }
}
