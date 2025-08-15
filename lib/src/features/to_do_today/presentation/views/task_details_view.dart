import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/to_do_today/application/controllers/task_details_controller.dart';
import '../../../to_do_today/domain/entities/task.dart';

class TaskDetailsView extends ConsumerStatefulWidget {
  final String taskId;
  const TaskDetailsView({super.key, required this.taskId});

  @override
  ConsumerState<TaskDetailsView> createState() => _TaskDetailsViewState();
}

class _TaskDetailsViewState extends ConsumerState<TaskDetailsView> {
  late final TextEditingController _titleCtrl;
  late final TextEditingController _descCtrl;
  final _titleFocus = FocusNode();
  final _descFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController();
    _descCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _titleFocus.dispose();
    _descFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncUi = ref.watch(taskDetailsControllerProvider(widget.taskId));
    final controller =
        ref.read(taskDetailsControllerProvider(widget.taskId).notifier);

    return WillPopScope(
      onWillPop: () async {
        final ui = asyncUi.valueOrNull;
        if (ui == null || !ui.hasUnsavedChanges || ui.isSaving) return true;

        final leave = await _confirmDiscard(context);
        return leave ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Task'),
          centerTitle: false,
          leading: IconButton(
            tooltip: 'Back',
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () async {
              final ui = asyncUi.valueOrNull;
              if (ui != null && ui.hasUnsavedChanges && !ui.isSaving) {
                final leave = await _confirmDiscard(context);
                if (leave != true) return;
              }
              if (mounted) Navigator.of(context).maybePop();
            },
          ),
          actions: [
            IconButton(
              tooltip: 'Refresh',
              icon: const Icon(Icons.refresh),
              onPressed: asyncUi.isLoading ? null : controller.refresh,
            ),
            IconButton(
              tooltip: 'Delete',
              icon: const Icon(Icons.delete_outline),
              onPressed: asyncUi.hasValue
                  ? () async {
                      final ok = await _confirmDelete(context);
                      if (ok == true) {
                        await controller.deleteTask();
                        if (mounted) Navigator.of(context).pop();
                      }
                    }
                  : null,
            ),
          ],
        ),
        body: asyncUi.when(
          loading: () => const _CenteredProgress(),
          error: (e, _) => _ErrorView(message: e.toString()),
          data: (ui) {
            // Initialize editors first time only (don’t overwrite user typing)
            if (_titleCtrl.text.isEmpty && _descCtrl.text.isEmpty) {
              _titleCtrl.text = ui.titleDraft;
              _descCtrl.text = ui.descriptionDraft;
            }

            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: _Header(
                        task: ui.task,
                        onToggle: (v) => controller.toggleCompleted(v),
                      ),
                    ),
                  ),

                  // Title
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _titleCtrl,
                        focusNode: _titleFocus,
                        onChanged: controller.setTitle,
                        style: Theme.of(context).textTheme.headlineSmall,
                        decoration: const InputDecoration(
                          hintText: 'Task title',
                          border: InputBorder.none,
                        ),
                        maxLines: 3,
                        minLines: 1,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ),

                  // Description
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _descCtrl,
                        focusNode: _descFocus,
                        onChanged: controller.setDescription,
                        decoration: const InputDecoration(
                          hintText: 'Notes, details…',
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                        minLines: 3,
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 12)),
                  const SliverToBoxAdapter(child: Divider(height: 1)),

                  // Meta (created at)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      child: _MetaRow(
                        icon: Icons.schedule_outlined,
                        label: 'Created',
                        value: _formatDate(ui.task.createdAt),
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: asyncUi.maybeWhen(
          data: (ui) => _SaveBar(
            visible: ui.hasUnsavedChanges || ui.isSaving,
            saving: ui.isSaving,
            onSave: () async {
              await controller.saveEdits();
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task saved')),
              );
            },
          ),
          orElse: () => const SizedBox.shrink(),
        ),
      ),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete task?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          FilledButton.tonal(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Delete')),
        ],
      ),
    );
  }

  Future<bool?> _confirmDiscard(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Discard changes?'),
        content: const Text('You have unsaved edits. Leave without saving?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Stay')),
          FilledButton.tonal(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Discard')),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    // Simple friendly date; replace with your AppDateUtils if you prefer
    final months = const [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${dt.day} ${months[dt.month]} ${dt.year}';
  }
}

/// Top area with completion toggle + small status
class _Header extends StatelessWidget {
  final Task task;
  final ValueChanged<bool> onToggle;

  const _Header({required this.task, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final statusColor = task.isCompleted ? Colors.green : Colors.orange;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: task.isCompleted,
          onChanged: (v) => onToggle(v ?? false),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: Text(
              task.isCompleted ? 'Completed' : 'In progress',
              key: ValueKey(task.isCompleted),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Simple row used in meta section
class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MetaRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        );
    final valueStyle = Theme.of(context).textTheme.bodyLarge;

    return Row(
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 10),
        Text(label, style: labelStyle),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            style: valueStyle,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

/// Save bar that slides in/out when there are edits or while saving
class _SaveBar extends StatelessWidget {
  final bool visible;
  final bool saving;
  final VoidCallback onSave;

  const _SaveBar({
    required this.visible,
    required this.saving,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 200),
      offset: visible ? Offset.zero : const Offset(0, 1),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: visible ? 1 : 0,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: saving ? null : onSave,
                    icon: saving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save_outlined),
                    label: Text(saving ? 'Saving…' : 'Save changes'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CenteredProgress extends StatelessWidget {
  const _CenteredProgress();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:
          SizedBox(width: 36, height: 36, child: CircularProgressIndicator()),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 40),
            const SizedBox(height: 8),
            Text('Oops', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
