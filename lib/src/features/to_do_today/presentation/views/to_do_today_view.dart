import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/completed_tasks.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/custom_app_bar.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/task_item.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/task_list.dart';

class ToDoTodayView extends StatefulWidget {
  const ToDoTodayView({super.key});

  @override
  State<ToDoTodayView> createState() => _ToDoTodayViewState();
}

class _ToDoTodayViewState extends State<ToDoTodayView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  final FocusNode _focusNode = FocusNode();
  bool _showSheet = false;
  late final KeyboardVisibilityController _keyboardController;
  late final Stream<bool> _keyboardStream;
  late final StreamSubscription<bool> _keyboardSub;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _offsetAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _keyboardController = KeyboardVisibilityController();
    _keyboardStream = _keyboardController.onChange;

    _keyboardSub = _keyboardStream.listen((visible) {
      // Only close sheet if keyboard closes while sheet is open
      if (!visible && _showSheet) {
        closeSheet();
      }
    });
  }

  @override
  void dispose() {
    _keyboardSub.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void openSheet() {
    // Prevent double open
    if (_showSheet) return;

    setState(() {
      _showSheet = true;
    });

    _controller.forward();
    // Delay focus so the animation starts before the keyboard comes up
    Future.delayed(const Duration(milliseconds: 120), () {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  void closeSheet() {
    if (!_showSheet) return;

    _focusNode.unfocus();
    _controller.reverse().then((_) {
      if (mounted) {
        setState(() {
          _showSheet = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          const SingleChildScrollView(
            child: Column(
              children: [
                TaskList(
                  title: 'Inbox',
                  tasks: [
                    TaskItem(
                      title: 'Make zentry',
                      time: '7 Aug',
                      isCompleted: false,
                      showRefresh: true,
                    ),
                    TaskItem(
                      title: 'صلاة الفجر',
                      time: '4:40 am',
                      isCompleted: false,
                      showRefresh: true,
                    ),
                    TaskItem(
                      title: 'Study UI / UX',
                      time: '31 Jul',
                      isCompleted: false,
                      showRefresh: false,
                    ),
                    TaskItem(
                      title: 'Memory quran',
                      time: '8 Aug',
                      isCompleted: false,
                      showRefresh: false,
                    ),
                  ],
                ),
                Divider(),
                CompletedTasks(),
              ],
            ),
          ),

          // Dark overlay
          if (_showSheet)
            Positioned.fill(
              child: GestureDetector(
                onTap: closeSheet,
                child: Container(color: Colors.black54),
              ),
            ),

          // Bottom Sheet
          if (_showSheet)
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: _offsetAnimation,
                child: AddTaskBottomSheet(focusNode: _focusNode),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_task_to_do_today',
        onPressed: openSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddTaskBottomSheet extends StatelessWidget {
  final FocusNode focusNode;

  const AddTaskBottomSheet({super.key, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height * 0.45;

    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              TextField(
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: 'What would you like to do?',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                minLines: 1,
                maxLines: null,
              ),
              const SizedBox(height: 6),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Description (optional)',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                minLines: 1,
                maxLines: null,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon: const Icon(Icons.calendar_today_outlined,
                        color: Colors.grey),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon:
                        const Icon(Icons.bookmark_outline, color: Colors.grey),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon: const Icon(Icons.label_outline, color: Colors.grey),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
