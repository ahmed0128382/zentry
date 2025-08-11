import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zentry/src/core/utils/app_colors.dart';
import 'package:zentry/src/features/calender/presentation/views/widgets/calender.dart';
import 'package:zentry/src/features/calender/presentation/views/widgets/calender_view_header.dart';
import 'package:zentry/src/features/calender/presentation/views/widgets/habits_section.dart';
import 'package:zentry/src/features/calender/presentation/views/widgets/section_divider.dart';
import 'package:zentry/src/features/calender/presentation/views/widgets/today_section.dart';

class CalenderView extends StatelessWidget {
  const CalenderView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CalenderViewHeader(),
            Calendar(),
            SectionDivider(),
            TodaySection(),
            SectionDivider(),
            HabitsSection(),
          ],
        ),
      ),
    );
  }
}
