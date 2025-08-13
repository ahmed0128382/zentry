class Task {
  final String id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description,
    DateTime? createdAt,
    this.isCompleted = false,
  }) : createdAt = createdAt ?? DateTime.now();

  Task copyWith({
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
