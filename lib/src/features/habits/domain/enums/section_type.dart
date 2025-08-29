import 'package:flutter/material.dart';

enum SectionType {
  morning,
  afternoon,
  evening,
  anytime,
}

extension SectionTypeX on SectionType {
  String get displayName {
    switch (this) {
      case SectionType.morning:
        return "Morning";
      case SectionType.afternoon:
        return "Afternoon";
      case SectionType.evening:
        return "Evening";
      case SectionType.anytime:
        return "AnyTime";
    }
  }

  // Optional: add an icon
  IconData get icon {
    switch (this) {
      case SectionType.morning:
        return Icons.wb_sunny_outlined;
      case SectionType.afternoon:
        return Icons.cloud_outlined;
      case SectionType.evening:
        return Icons.nights_stay_outlined;
      case SectionType.anytime:
        return Icons.star_border;
    }
  }
}
