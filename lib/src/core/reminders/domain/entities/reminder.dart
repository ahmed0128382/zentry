// import 'dart:convert';
// import 'package:equatable/equatable.dart';
// import 'package:zentry/src/core/reminders/domain/value_objects/reminder_time.dart';

// class Reminder extends Equatable {
//   final String id;
//   final String ownerId;
//   final String ownerType;
//   final ReminderTime time;
//   final bool enabled;
//   final List<int> weekdays;
//   final String? title;
//   final String? body;
//   final Map<String, dynamic>? metadata;

//   const Reminder({
//     required this.id,
//     required this.ownerId,
//     required this.ownerType,
//     required this.time,
//     this.enabled = true,
//     this.weekdays = const [],
//     this.title,
//     this.body,
//     this.metadata,
//   });

//   String toPayloadJson() {
//     final map = {
//       'reminderId': id,
//       'ownerId': ownerId,
//       'ownerType': ownerType,
//       'time': time.toJson(),
//       'enabled': enabled,
//       if (weekdays.isNotEmpty) 'weekdays': weekdays,
//       if (title != null) 'title': title,
//       if (body != null) 'body': body,
//       if (metadata != null) 'metadata': metadata,
//     };
//     return jsonEncode(map);
//   }

//   factory Reminder.fromMap(Map<String, dynamic> m) {
//     return Reminder(
//       id: m['id'] as String,
//       ownerId: m['ownerId'] as String,
//       ownerType: m['ownerType'] as String,
//       time: ReminderTime.fromJson(m['time'] as Map<String, dynamic>),
//       enabled: m['enabled'] as bool? ?? true,
//       weekdays:
//           (m['weekdays'] as List<dynamic>?)?.map((e) => e as int).toList() ??
//               const [],
//       title: m['title'] as String?,
//       body: m['body'] as String?,
//       metadata: m['metadata'] == null
//           ? null
//           : Map<String, dynamic>.from(m['metadata'] as Map),
//     );
//   }

//   Map<String, dynamic> toMap() => {
//         'id': id,
//         'ownerId': ownerId,
//         'ownerType': ownerType,
//         'time': time.toJson(),
//         'enabled': enabled,
//         'weekdays': weekdays,
//         'title': title,
//         'body': body,
//         'metadata': metadata,
//       };

//   int computeNotificationId() {
//     final key = '$id|$ownerId|${time.totalSecondsSinceMidnight}';
//     return _fnv1a32(key) & 0x7FFFFFFF;
//   }

//   static int _fnv1a32(String s) {
//     var hash = 0x811C9DC5;
//     for (var i = 0; i < s.length; i++) {
//       hash ^= s.codeUnitAt(i);
//       hash = (hash * 0x01000193) & 0xFFFFFFFF;
//     }
//     return hash;
//   }

//   Reminder copyWith({
//     String? id,
//     String? ownerId,
//     String? ownerType,
//     ReminderTime? time,
//     bool? enabled,
//     List<int>? weekdays,
//     String? title,
//     String? body,
//     Map<String, dynamic>? metadata,
//   }) {
//     return Reminder(
//       id: id ?? this.id,
//       ownerId: ownerId ?? this.ownerId,
//       ownerType: ownerType ?? this.ownerType,
//       time: time ?? this.time,
//       enabled: enabled ?? this.enabled,
//       weekdays: weekdays ?? this.weekdays,
//       title: title ?? this.title,
//       body: body ?? this.body,
//       metadata: metadata ?? this.metadata,
//     );
//   }

//   @override
//   List<Object?> get props =>
//       [id, ownerId, ownerType, time, enabled, weekdays, title, body, metadata];
// }
// // File: src/core/reminders/domain/entities/reminder.dart
// import 'dart:convert';
// import 'package:equatable/equatable.dart';
// import 'package:zentry/src/core/reminders/domain/entities/periodic_types.dart';
// import 'package:zentry/src/core/reminders/domain/value_objects/reminder_time.dart';

// class Reminder extends Equatable {
//   final String id;
//   final String ownerId;
//   final String ownerType;
//   final ReminderTime time;
//   final bool enabled;
//   final List<int> weekdays;
//   final String? title;
//   final String? body;
//   final Map<String, dynamic>? metadata;

//   /// NEW: periodic type (optional)
//   final PeriodicType? periodicType;

//   const Reminder({
//     required this.id,
//     required this.ownerId,
//     required this.ownerType,
//     required this.time,
//     this.enabled = true,
//     this.weekdays = const [],
//     this.title,
//     this.body,
//     this.metadata,
//     this.periodicType, // added
//   });

//   String toPayloadJson() {
//     final map = {
//       'reminderId': id,
//       'ownerId': ownerId,
//       'ownerType': ownerType,
//       'time': time.toJson(),
//       'enabled': enabled,
//       if (weekdays.isNotEmpty) 'weekdays': weekdays,
//       if (title != null) 'title': title,
//       if (body != null) 'body': body,
//       if (metadata != null) 'metadata': metadata,
//       if (periodicType != null)
//         'periodicType': periodicType.toString().split('.').last,
//     };
//     return jsonEncode(map);
//   }

//   factory Reminder.fromMap(Map<String, dynamic> m) {
//     return Reminder(
//       id: m['id'] as String,
//       ownerId: m['ownerId'] as String,
//       ownerType: m['ownerType'] as String,
//       time: ReminderTime.fromJson(m['time'] as Map<String, dynamic>),
//       enabled: m['enabled'] as bool? ?? true,
//       weekdays:
//           (m['weekdays'] as List<dynamic>?)?.map((e) => e as int).toList() ??
//               const [],
//       title: m['title'] as String?,
//       body: m['body'] as String?,
//       metadata: m['metadata'] == null
//           ? null
//           : Map<String, dynamic>.from(m['metadata'] as Map),
//       periodicType: m['periodicType'] != null
//           ? PeriodicType.values.firstWhere(
//               (e) => e.toString().split('.').last == m['periodicType'],
//               orElse: () => PeriodicType.daily,
//             )
//           : null,
//     );
//   }

//   Map<String, dynamic> toMap() => {
//         'id': id,
//         'ownerId': ownerId,
//         'ownerType': ownerType,
//         'time': time.toJson(),
//         'enabled': enabled,
//         'weekdays': weekdays,
//         'title': title,
//         'body': body,
//         'metadata': metadata,
//         if (periodicType != null)
//           'periodicType': periodicType.toString().split('.').last,
//       };

//   /// Compute a stable notification id for non-weekly reminders (or as a base id).
//   int computeNotificationId() {
//     final key = '$id|$ownerId|${time.totalSecondsSinceMidnight}';
//     return _fnv1a32(key) & 0x7FFFFFFF;
//   }

//   /// Compute **all** notification ids that correspond to this Reminder.
//   ///
//   /// - If `weekdays` is empty -> returns a single id (daily / one-time).
//   /// - If `weekdays` contains values -> returns one id per weekday in the
//   ///   same order as `weekdays`. Each id is deterministic and distinct.
//   List<int> computeNotificationIds() {
//     if (weekdays.isEmpty) return [computeNotificationId()];

//     return weekdays.map((wd) {
//       // include the weekday in the hash key so each day gets its own id
//       final key = '$id|$ownerId|${time.totalSecondsSinceMidnight}|$wd';
//       return _fnv1a32(key) & 0x7FFFFFFF;
//     }).toList();
//   }

//   static int _fnv1a32(String s) {
//     var hash = 0x811C9DC5;
//     for (var i = 0; i < s.length; i++) {
//       hash ^= s.codeUnitAt(i);
//       hash = (hash * 0x01000193) & 0xFFFFFFFF;
//     }
//     return hash;
//   }

//   Reminder copyWith({
//     String? id,
//     String? ownerId,
//     String? ownerType,
//     ReminderTime? time,
//     bool? enabled,
//     List<int>? weekdays,
//     String? title,
//     String? body,
//     Map<String, dynamic>? metadata,
//     PeriodicType? periodicType,
//   }) {
//     return Reminder(
//       id: id ?? this.id,
//       ownerId: ownerId ?? this.ownerId,
//       ownerType: ownerType ?? this.ownerType,
//       time: time ?? this.time,
//       enabled: enabled ?? this.enabled,
//       weekdays: weekdays ?? this.weekdays,
//       title: title ?? this.title,
//       body: body ?? this.body,
//       metadata: metadata ?? this.metadata,
//       periodicType: periodicType ?? this.periodicType,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         id,
//         ownerId,
//         ownerType,
//         time,
//         enabled,
//         weekdays,
//         title,
//         body,
//         metadata,
//         periodicType,
//       ];
// }
// File: src/core/reminders/domain/entities/reminder.dart

import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:zentry/src/core/reminders/domain/entities/periodic_types.dart';
import 'package:zentry/src/core/reminders/domain/value_objects/reminder_time.dart';

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

  /// NEW: periodic type (optional)
  final PeriodicType? periodicType;

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
    this.periodicType,
  });

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
      if (periodicType != null)
        'periodicType': periodicType.toString().split('.').last,
    };
    return jsonEncode(map);
  }

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
      metadata: m['metadata'] == null
          ? null
          : Map<String, dynamic>.from(m['metadata'] as Map),
      periodicType: m['periodicType'] != null
          ? PeriodicType.values.firstWhere(
              (e) => e.toString().split('.').last == m['periodicType'],
              orElse: () => PeriodicType.daily,
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'ownerId': ownerId,
        'ownerType': ownerType,
        'time': time.toJson(),
        'enabled': enabled,
        'weekdays': weekdays,
        'title': title,
        'body': body,
        'metadata': metadata,
        if (periodicType != null)
          'periodicType': periodicType.toString().split('.').last,
      };

  /// Compute a stable notification id for non-weekly reminders (or as a base id).
  int computeNotificationId() {
    final key = '$id|$ownerId|${time.totalSecondsSinceMidnight}';
    return _fnv1a32(key) & 0x7FFFFFFF;
  }

  /// Compute **all** notification ids that correspond to this Reminder.
  ///
  /// - If `weekdays` is empty -> returns a single id (daily / one-time).
  /// - If `weekdays` contains values -> returns one id per weekday in the
  ///   same order as `weekdays`. Each id is deterministic and distinct.
  List<int> computeNotificationIds() {
    if (weekdays.isEmpty) return [computeNotificationId()];

    return weekdays.map((wd) {
      // include the weekday in the hash key so each day gets its own id
      final key = '$id|$ownerId|${time.totalSecondsSinceMidnight}|$wd';
      return _fnv1a32(key) & 0x7FFFFFFF;
    }).toList();
  }

  static int _fnv1a32(String s) {
    var hash = 0x811C9DC5;
    for (var i = 0; i < s.length; i++) {
      hash ^= s.codeUnitAt(i);
      hash = (hash * 0x01000193) & 0xFFFFFFFF;
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
    PeriodicType? periodicType,
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
      periodicType: periodicType ?? this.periodicType,
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
        periodicType,
      ];
}
