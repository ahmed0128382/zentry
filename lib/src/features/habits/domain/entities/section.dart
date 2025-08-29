import '../enums/section_type.dart';

class Section {
  final String id; // UUID
  final SectionType type;
  final int orderIndex; // for sorting sections in UI

  const Section({
    required this.id,
    required this.type,
    required this.orderIndex,
  });
}

const sectionIds = {
  SectionType.morning: 'morning',
  SectionType.afternoon: 'afternoon',
  SectionType.evening: 'evening',
  SectionType.anytime: 'anytime',
};
