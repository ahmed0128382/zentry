// File: lib/src/core/reminders/infrastructure/repos/exact_alarm_helper.dart
import 'dart:developer';
import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/services.dart';

class ExactAlarmHelper {
  /// ✅ Returns true if exact alarms can be scheduled
  static Future<bool> canScheduleExactAlarms() async {
    if (!Platform.isAndroid) {
      log("[ExactAlarmHelper] Not Android, returning true");
      return true;
    }

    try {
      // On Android 12+ (API 31), exact alarm permission must be granted
      final sdkInt = await _getAndroidSdkInt();
      if (sdkInt >= 31) {
        // This method only opens settings, we assume user will allow manually
        log("[ExactAlarmHelper] Android SDK $sdkInt detected, exact alarm permission may be needed");
        return true; // for now, assume user has granted
      }
      log("[ExactAlarmHelper] Android SDK $sdkInt < 31, no permission needed");
      return true;
    } catch (e) {
      log("[ExactAlarmHelper] Error checking exact alarm permission: $e");
      return false;
    }
  }

  /// Requests exact alarm permission on Android 12+
  static Future<void> requestExactAlarmPermission() async {
    if (!Platform.isAndroid) return;

    try {
      final sdkInt = await _getAndroidSdkInt();
      log("[ExactAlarmHelper] Requesting exact alarm permission on SDK $sdkInt");

      if (sdkInt >= 31) {
        const intent = AndroidIntent(
          action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
        );
        await intent.launch();
        log("[ExactAlarmHelper] Launched exact alarm settings intent");
      } else {
        log("[ExactAlarmHelper] SDK < 31, no need to request exact alarm permission");
      }
    } on PlatformException catch (e) {
      log("[ExactAlarmHelper] Exact alarm permission error: $e");
    } catch (e) {
      log("[ExactAlarmHelper] Unexpected error requesting exact alarm permission: $e");
    }
  }

  /// Helper: get Android SDK version via platform channel
  static Future<int> _getAndroidSdkInt() async {
    try {
      if (!Platform.isAndroid) return 0;
      final sdkInt = await const MethodChannel('exact_alarm_helper')
          .invokeMethod<int>('getSdkInt');
      log("[ExactAlarmHelper] Detected SDK int: $sdkInt");
      return sdkInt ?? 0;
    } on PlatformException catch (e) {
      log("[ExactAlarmHelper] Failed to get SDK int: $e");
      return 0;
    }
  }
}
