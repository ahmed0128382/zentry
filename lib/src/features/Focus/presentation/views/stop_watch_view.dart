import 'package:flutter/material.dart';

class StopWatchView extends StatelessWidget {
  const StopWatchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 24.0),
            _buildMainContent(context),
            const SizedBox(height: 24.0),
            _buildStartButton(),
            const SizedBox(height: 24.0), // replaces Spacer
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Focus',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8.0),
              Icon(
                Icons.arrow_forward_ios,
                size: 16.0,
                color: Colors.grey[600],
              ),
            ],
          ),
          const SizedBox(height: 48.0),
          CustomPaint(
            painter: DottedCirclePainter(),
            child: const SizedBox(
              width: 200,
              height: 200,
              child: Center(
                child: Text(
                  '00:00',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: () {
          // Handle start button press
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        child: const Text(
          'Start',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class DottedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
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
