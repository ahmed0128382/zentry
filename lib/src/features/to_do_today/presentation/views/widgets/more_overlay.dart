// import 'package:flutter/material.dart';

// class MoreOverlay extends StatefulWidget {
//   final VoidCallback? onOption1;
//   final VoidCallback? onOption2;
//   final VoidCallback? onOption3;

//   const MoreOverlay(
//       {super.key, this.onOption1, this.onOption2, this.onOption3});

//   @override
//   State<MoreOverlay> createState() => _MoreOverlayState();
// }

// class _MoreOverlayState extends State<MoreOverlay> {
//   final LayerLink _layerLink = LayerLink();
//   OverlayEntry? _overlayEntry;
//   bool _isOpen = false;

//   void _toggleOverlay() {
//     if (_isOpen) {
//       _overlayEntry?.remove();
//       _overlayEntry = null;
//     } else {
//       _overlayEntry = _createOverlayEntry();
//       Overlay.of(context).insert(_overlayEntry!);
//     }
//     setState(() => _isOpen = !_isOpen);
//   }

//   OverlayEntry _createOverlayEntry() {
//     final renderBox = context.findRenderObject() as RenderBox;
//     final size = renderBox.size;
//     final offset = renderBox.localToGlobal(Offset.zero);
//     final screenSize = MediaQuery.of(context).size;

//     // Limit left position so overlay stays on screen
//     double left = offset.dx;
//     const overlayWidth = 200.0; // you can adjust

//     if (left + overlayWidth > screenSize.width) {
//       left = screenSize.width - overlayWidth - 16; // 16px margin from edge
//     }

//     // Max height so overlay doesn't overflow bottom
//     final maxHeight = screenSize.height - offset.dy - size.height - 16;

//     return OverlayEntry(
//       builder: (context) => GestureDetector(
//         onTap: _toggleOverlay,
//         behavior: HitTestBehavior.translucent,
//         child: Stack(
//           children: [
//             Positioned(
//               left: left,
//               top: offset.dy + size.height,
//               width: overlayWidth,
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(maxHeight: maxHeight),
//                 child: Material(
//                   elevation: 4,
//                   borderRadius: BorderRadius.circular(8),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         _buildOption('Option 1', widget.onOption1),
//                         _buildOption('Option 2', widget.onOption2),
//                         _buildOption('Option 3', widget.onOption3),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOption(String label, VoidCallback? onTap) {
//     return InkWell(
//       onTap: () {
//         onTap?.call();
//         _toggleOverlay();
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         child: Text(label),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CompositedTransformTarget(
//       link: _layerLink,
//       child: IconButton(
//         icon: const Icon(Icons.more_vert),
//         onPressed: _toggleOverlay,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class MoreOverlayOption {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  MoreOverlayOption({
    required this.icon,
    required this.label,
    this.onTap,
  });
}

class MoreOverlay extends StatefulWidget {
  final List<MoreOverlayOption> options;

  const MoreOverlay({super.key, required this.options});

  @override
  State<MoreOverlay> createState() => _MoreOverlayState();
}

class _MoreOverlayState extends State<MoreOverlay> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _toggleOverlay() {
    if (_isOpen) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
    setState(() => _isOpen = !_isOpen);
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final screenSize = MediaQuery.of(context).size;

    double left = offset.dx;
    const overlayWidth = 220.0;

    if (left + overlayWidth > screenSize.width) {
      left = screenSize.width - overlayWidth - 16;
    }

    final maxHeight = screenSize.height - offset.dy - size.height - 16;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _toggleOverlay,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              left: left,
              top: offset.dy + size.height,
              width: overlayWidth,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxHeight),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.options
                          .map((option) => _buildOption(option))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(MoreOverlayOption option) {
    return InkWell(
      onTap: () {
        option.onTap?.call();
        _toggleOverlay();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(option.icon, size: 20),
            const SizedBox(width: 12),
            Text(option.label),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: _toggleOverlay,
      ),
    );
  }
}
