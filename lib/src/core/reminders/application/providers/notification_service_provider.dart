import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/reminders/domain/repos/notification_service.dart';
import 'package:zentry/src/core/reminders/infrastructure/repos/local_notification_service_impl.dart';

/// Provides a concrete implementation of NotificationService
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return LocalNotificationServiceImpl();
});
