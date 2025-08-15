import 'package:flutter/material.dart';

class CenteredProgress extends StatelessWidget {
  const CenteredProgress({super.key});
  @override
  Widget build(BuildContext context) => const Center(
        child:
            SizedBox(width: 36, height: 36, child: CircularProgressIndicator()),
      );
}
