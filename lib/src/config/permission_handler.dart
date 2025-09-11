// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:permission_handler/permission_handler.dart';

// enum EnNotificationPermissionStatus {
//   granted,
//   denied,
//   permanentlyDenied,
//   restricted,
//   limited,
//   none,
// }

// /// Provider to manage notification permissions
// final notificationPermissionProvider = StateNotifierProvider<
//     NotificationPermissionNotifier, EnNotificationPermissionStatus>(
//   (ref) => NotificationPermissionNotifier(),
// );

// class NotificationPermissionNotifier
//     extends StateNotifier<EnNotificationPermissionStatus> {
//   NotificationPermissionNotifier()
//       : super(EnNotificationPermissionStatus.denied);

//   /// Convert [PermissionStatus] to [EnNotificationPermissionStatus]
//   EnNotificationPermissionStatus _convertStatus(PermissionStatus status) {
//     switch (status) {
//       case PermissionStatus.granted:
//         return EnNotificationPermissionStatus.granted;
//       case PermissionStatus.denied:
//         return EnNotificationPermissionStatus.denied;
//       case PermissionStatus.permanentlyDenied:
//         return EnNotificationPermissionStatus.permanentlyDenied;
//       case PermissionStatus.restricted:
//         return EnNotificationPermissionStatus.restricted;
//       case PermissionStatus.limited:
//         return EnNotificationPermissionStatus.limited;
//       default:
//         return EnNotificationPermissionStatus.none;
//     }
//   }

//   /// Get current notification permission status
//   Future<void> checkPermission() async {
//     final status = await Permission.notification.status;
//     state = _convertStatus(status);
//   }

//   /// Request notification permission
//   Future<void> requestPermission() async {
//     final status = await Permission.notification.request();
//     state = _convertStatus(status);
//   }

//   /// Returns true if notifications are allowed
//   bool get isGranted => state == EnNotificationPermissionStatus.granted;
// }
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

/// Unified permission statuses
enum EnPermissionStatus {
  granted,
  denied,
  permanentlyDenied,
  restricted,
  limited,
  none,
}

/// Provider to manage notification + exact alarm permissions
final permissionHandlerProvider =
    StateNotifierProvider<PermissionHandlerNotifier, PermissionState>(
  (ref) => PermissionHandlerNotifier(),
);

/// State holds both notification and exact alarm permission statuses
class PermissionState {
  final EnPermissionStatus notification;
  final EnPermissionStatus exactAlarm;

  const PermissionState({
    this.notification = EnPermissionStatus.denied,
    this.exactAlarm = EnPermissionStatus.denied,
  });

  PermissionState copyWith({
    EnPermissionStatus? notification,
    EnPermissionStatus? exactAlarm,
  }) {
    return PermissionState(
      notification: notification ?? this.notification,
      exactAlarm: exactAlarm ?? this.exactAlarm,
    );
  }
}

class PermissionHandlerNotifier extends StateNotifier<PermissionState> {
  PermissionHandlerNotifier() : super(const PermissionState());
  EnPermissionStatus notificationPermission = EnPermissionStatus.denied;
  EnPermissionStatus exactAlarmPermission =
      Platform.isIOS ? EnPermissionStatus.granted : EnPermissionStatus.denied;

  /// Convert [PermissionStatus] to [EnPermissionStatus]
  EnPermissionStatus _convertStatus(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return EnPermissionStatus.granted;
      case PermissionStatus.denied:
        return EnPermissionStatus.denied;
      case PermissionStatus.permanentlyDenied:
        return EnPermissionStatus.permanentlyDenied;
      case PermissionStatus.restricted:
        return EnPermissionStatus.restricted;
      case PermissionStatus.limited:
        return EnPermissionStatus.limited;
      default:
        return EnPermissionStatus.none;
    }
  }

  Future<EnPermissionStatus> getNotificationPermissionStatus() async {
    final status = await Permission.notification.status;
    return _convertStatus(status);
  }

  Future<EnPermissionStatus> getExactAlarmPermissionStatus() async {
    if (Platform.isIOS) return EnPermissionStatus.granted;
    final status = await Permission.scheduleExactAlarm.status;
    return _convertStatus(status);
  }

  Future checkPermissions() async {
    notificationPermission = await getNotificationPermissionStatus();
    exactAlarmPermission = await getExactAlarmPermissionStatus();
    state = state.copyWith(
      notification: notificationPermission,
      exactAlarm: exactAlarmPermission,
    );
  }

  // /// Check notification permission
  // Future<void> checkNotificationPermission() async {
  //   final status = await Permission.notification.status;
  //   state = state.copyWith(notification: _convertStatus(status));
  // }

  /// Request notification permission
  Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    state = state.copyWith(notification: _convertStatus(status));
  }

  // /// Check exact alarm permission (Android 13+)
  // Future<void> checkExactAlarmPermission() async {
  //   final status = await Permission.scheduleExactAlarm.status;
  //   state = state.copyWith(exactAlarm: _convertStatus(status));
  // }

  /// Request exact alarm permission
  Future<void> requestExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.request();
    state = state.copyWith(exactAlarm: _convertStatus(status));
  }

  /// Quick getters
  bool get isNotificationGranted =>
      state.notification == EnPermissionStatus.granted;

  bool get isExactAlarmGranted =>
      state.exactAlarm == EnPermissionStatus.granted;
}
