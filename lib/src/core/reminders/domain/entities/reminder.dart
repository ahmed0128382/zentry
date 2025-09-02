// lib/src/core/reminders/domain/entities/reminder.dart

import 'dart:convert';
import 'package:equatable/equatable.dart';

/// Generic reminder entity used across features (habits, tasks, etc).
/// - `ownerId` is the id of the owning domain entity (e.g. habit id, task id).
/// - `ownerType` is a string like 'habit' or 'task' (optional, helpful for routing
///   when the user taps a notification).
/// - `minutesSinceMidnight` is 0..1439 representing the scheduled local time.
class Reminder extends Equatable {
  final String id;
  final String ownerId;
  final String ownerType;
  final int minutesSinceMidnight;
  final bool enabled;
  final String? title;
  final String? body;
  final Map<String, dynamic>? metadata;

  const Reminder({
    required this.id,
    required this.ownerId,
    required this.ownerType,
    required this.minutesSinceMidnight,
    this.enabled = true,
    this.title,
    this.body,
    this.metadata,
  });

  /// hour (0..23)
  int get hour => minutesSinceMidnight ~/ 60;

  /// minute (0..59)
  int get minute => minutesSinceMidnight % 60;

  /// Convert to a payload string for notifications. Keep it small and deterministic.
  /// The consumer (on notification tap) can decode JSON to route the user.
  String toPayloadJson() {
    final map = {
      'reminderId': id,
      'ownerId': ownerId,
      'ownerType': ownerType,
      'minutesSinceMidnight': minutesSinceMidnight,
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
      minutesSinceMidnight: m['minutesSinceMidnight'] as int,
      enabled: m['enabled'] as bool? ?? true,
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
      'minutesSinceMidnight': minutesSinceMidnight,
      'enabled': enabled,
      'title': title,
      'body': body,
      'metadata': metadata,
    };
  }

  /// Compute a **deterministic** int id for scheduling notifications.
  ///
  /// flutter_local_notifications needs an `int` id. We generate one deterministically
  /// from `id + ownerId + minutes` using the FNV-1a 32-bit algorithm and return
  /// a non-negative int suitable for the plugin.
  ///
  /// Use this same function whenever you schedule / cancel a notification so
  /// the plugin ids match.
  int computeNotificationId() {
    final key = '$id|$ownerId|$minutesSinceMidnight';
    return _fnv1a32(key) & 0x7FFFFFFF; // ensure non-negative
  }

  /// Simple FNV-1a 32-bit hash (deterministic across runs).
  /// Good enough for generating notification ids from strings.
  static int _fnv1a32(String s) {
    var hash = 0x811C9DC5; // 2166136261
    for (var i = 0; i < s.length; i++) {
      hash ^= s.codeUnitAt(i);
      // multiply by FNV prime 16777619 modulo 2^32
      hash = (hash * 0x01000193) & 0xFFFFFFFF;
    }
    return hash;
  }

  Reminder copyWith({
    String? id,
    String? ownerId,
    String? ownerType,
    int? minutesSinceMidnight,
    bool? enabled,
    String? title,
    String? body,
    Map<String, dynamic>? metadata,
  }) {
    return Reminder(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      ownerType: ownerType ?? this.ownerType,
      minutesSinceMidnight: minutesSinceMidnight ?? this.minutesSinceMidnight,
      enabled: enabled ?? this.enabled,
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
        minutesSinceMidnight,
        enabled,
        title,
        body,
        metadata
      ];
}
