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
