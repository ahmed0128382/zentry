import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:zentry/src/core/reminders/domain/value_objects/reminder_time.dart';

/// Generic reminder entity used across features (habits, tasks, etc).
/// - `ownerId` is the id of the owning domain entity (e.g. habit id, task id).
/// - `ownerType` is a string like 'habit' or 'task' (optional, helpful for routing).
/// - `time` is a value object representing the scheduled local time.
/// - `weekdays` is a list of weekdays (1=Mon .. 7=Sun). Empty = daily.
class Reminder extends Equatable {
  final String id;
  final String ownerId;
  final String ownerType;
  final ReminderTime time;
  final bool enabled;
  final List<int> weekdays;
  final String? title;
  final String? body;
  final Map<String, dynamic>? metadata;

  const Reminder({
    required this.id,
    required this.ownerId,
    required this.ownerType,
    required this.time,
    this.enabled = true,
    this.weekdays = const [],
    this.title,
    this.body,
    this.metadata,
  });

  /// Convert to a payload string for notifications.
  /// The consumer (on notification tap) can decode JSON to route the user.
  String toPayloadJson() {
    final map = {
      'reminderId': id,
      'ownerId': ownerId,
      'ownerType': ownerType,
      'time': time.toJson(),
      'enabled': enabled,
      if (weekdays.isNotEmpty) 'weekdays': weekdays,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (metadata != null) 'metadata': metadata,
    };
    return jsonEncode(map);
  }

  /// Deserialize from a Map (e.g. from DB mapper)
  factory Reminder.fromMap(Map<String, dynamic> m) {
    return Reminder(
      id: m['id'] as String,
      ownerId: m['ownerId'] as String,
      ownerType: m['ownerType'] as String,
      time: ReminderTime.fromJson(m['time'] as Map<String, dynamic>),
      enabled: m['enabled'] as bool? ?? true,
      weekdays:
          (m['weekdays'] as List<dynamic>?)?.map((e) => e as int).toList() ??
              const [],
      title: m['title'] as String?,
      body: m['body'] as String?,
      metadata: (m['metadata'] == null)
          ? null
          : Map<String, dynamic>.from(m['metadata'] as Map),
    );
  }

  /// Convert to Map (useful for DB mappers)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerId': ownerId,
      'ownerType': ownerType,
      'time': time.toJson(),
      'enabled': enabled,
      'weekdays': weekdays,
      'title': title,
      'body': body,
      'metadata': metadata,
    };
  }

  /// Compute a deterministic int id for scheduling notifications.
  /// We use FNV-1a hash of `id + ownerId + time`.
  int computeNotificationId() {
    final key = '$id|$ownerId|${time.minutesSinceMidnight}';
    return _fnv1a32(key) & 0x7FFFFFFF; // ensure non-negative
  }

  /// Simple FNV-1a 32-bit hash (deterministic across runs).
  static int _fnv1a32(String s) {
    var hash = 0x811C9DC5; // 2166136261
    for (var i = 0; i < s.length; i++) {
      hash ^= s.codeUnitAt(i);
      hash = (hash * 0x01000193) & 0xFFFFFFFF; // *16777619 mod 2^32
    }
    return hash;
  }

  Reminder copyWith({
    String? id,
    String? ownerId,
    String? ownerType,
    ReminderTime? time,
    bool? enabled,
    List<int>? weekdays,
    String? title,
    String? body,
    Map<String, dynamic>? metadata,
  }) {
    return Reminder(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      ownerType: ownerType ?? this.ownerType,
      time: time ?? this.time,
      enabled: enabled ?? this.enabled,
      weekdays: weekdays ?? this.weekdays,
      title: title ?? this.title,
      body: body ?? this.body,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
        id,
        ownerId,
        ownerType,
        time,
        enabled,
        weekdays,
        title,
        body,
        metadata,
      ];
}
