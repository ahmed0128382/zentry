import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
import 'package:zentry/src/core/reminders/domain/value_objects/reminder_time.dart';
import 'package:zentry/src/core/reminders/infrastructure/repos/local_notification_service_impl.dart';
import 'package:zentry/src/core/reminders/presentation/views/test_reminder_screen.dart';
import 'package:zentry/src/features/to_do_today/application/providers/to_do_today_controller_provider.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/add_task_bottom_sheet.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/custom_app_bar.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/overlay_dismiss.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/task_content.dart';

class ToDoTodayView extends ConsumerStatefulWidget {
  const ToDoTodayView({super.key});

  @override
  ConsumerState<ToDoTodayView> createState() => _ToDoTodayViewState();
}

class _ToDoTodayViewState extends ConsumerState<ToDoTodayView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = ref.watch(appPaletteProvider);
    final showSheet = ref.watch(toDoTodayControllerProvider);
    final controller = ref.read(toDoTodayControllerProvider.notifier);

    // Sync animation controller in the notifier
    controller.animationController = _animationController;

    return Scaffold(
      backgroundColor: palette.background,
      appBar: const CustomAppBar(),
      body: Container(
        //color: palette.background,
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      LocalNotificationServiceImpl.senSimpleNotification();
                      //context.push(ReminderTestPage.routeName);
                    },
                    child: const Text("Schedule Test Notification (+1 min)"),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      LocalNotificationServiceImpl.cancelllNotifications();
                    },
                    child: const Text("Cancel All Notifications"),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      Reminder reminder = Reminder(
                          ownerId: '2',
                          title: 'Test Reminder',
                          id: '3',
                          ownerType: 'toDoToday',
                          time: ReminderTime(12, 3));
                      await LocalNotificationServiceImpl()
                          .scheduleNotification(reminder);
                    },
                    child: const Text("schedule Notification for 20 s"),
                  ),
                ],
              ),
            ),
            const TaskContent(),
            if (showSheet) const OverlayDismiss(),
            if (showSheet)
              SlideTransition(
                position: _offsetAnimation,
                child: AddTaskBottomSheet(
                  titleFocusNode: controller.titleFocusNode,
                  descriptionFocusNode: controller.descriptionFocusNode,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: palette.primary.withValues(alpha: 0.8),
        heroTag: 'add_task_to_do_today',
        onPressed: () => controller.openSheet(vsync: this),
        child: Icon(
          Icons.add,
          color: palette.icon,
        ),
      ),
    );
  }
}
