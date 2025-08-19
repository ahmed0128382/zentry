import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';

class StopWatchView extends ConsumerWidget {
  const StopWatchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(appPaletteProvider);

    return SafeArea(
      child: Container(
        color: palette.background,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            // "Focus" header
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Focus',
                  style: TextStyle(
                    fontSize: 18,
                    color: palette.primary.withValues(alpha: 0.8),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: palette.icon.withValues(alpha: 0.6),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Timer circle with dotted painter
            CustomPaint(
              painter: DottedCirclePainter(
                  color: palette.primary.withValues(alpha: 0.3)),
              child: const SizedBox(
                width: 220,
                height: 220,
                child: Center(
                  child: Text(
                    '00:00',
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            // "Start" button
            ElevatedButton(
              onPressed: () {
                // Start stopwatch
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: palette.primary,
                minimumSize: const Size(200, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Start',
                style: TextStyle(
                  fontSize: 18,
                  color: palette.text,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DottedCirclePainter extends CustomPainter {
  final Color color;

  DottedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    const double dotSpacing = 8.0;
    const double dotLength = 2.0;

    final double radius = size.width / 2;
    final double startAngle = -90 * (3.1415926535 / 180);
    final double endAngle = 270 * (3.1415926535 / 180);

    for (double i = startAngle; i < endAngle; i += dotSpacing / radius) {
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        i,
        dotLength / radius,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
