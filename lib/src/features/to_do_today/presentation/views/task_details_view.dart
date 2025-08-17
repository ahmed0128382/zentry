import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/core/utils/app_date_utils.dart';
import 'package:zentry/src/features/appearance/application/providers/appearance_controller_provider.dart';
import 'package:zentry/src/features/appearance/application/providers/appearance_repo_provider.dart';
import 'package:zentry/src/features/to_do_today/application/providers/task_details_controller_provider.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/centered_progress.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/confirm_dialogs.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/editable_text_field.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/error_view.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/meta_row.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/save_bar.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/task_header.dart';

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
    final palette = ref.watch(appPaletteProvider);
    final appearance = ref.watch(appearanceControllerProvider);

    final asyncUi = ref.watch(taskDetailsControllerProvider(widget.taskId));
    final controller =
        ref.read(taskDetailsControllerProvider(widget.taskId).notifier);

    return WillPopScope(
      onWillPop: () async {
        final ui = asyncUi.valueOrNull;
        if (ui == null || !ui.hasUnsavedChanges || ui.isSaving) return true;
        final leave = await showDiscardDialog(context, ref, widget.taskId);
        return leave ?? false;
      },
      child: Scaffold(
        backgroundColor: palette.background,
        appBar: AppBar(
          title: const Text('Task'),
          centerTitle: false,
          leading: IconButton(
            tooltip: 'Back',
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () {
              // Let WillPopScope handle discard confirmation
              Navigator.of(context).maybePop();
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
                      final ok = await showDeleteDialog(context);
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
          loading: () => const CenteredProgress(),
          error: (e, _) => ErrorView(message: e.toString()),
          data: (ui) {
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
                      child: TaskHeader(
                        task: ui.task,
                        onToggle: (v) => controller.toggleCompleted(v),
                      ),
                    ),
                  ),

                  // Title field
                  EditableTextField(
                    controller: _titleCtrl,
                    focusNode: _titleFocus,
                    hint: 'Task title',
                    style: Theme.of(context).textTheme.headlineSmall,
                    onChanged: controller.setTitle,
                    minLines: 1,
                    maxLines: 3,
                  ),

                  // Description field
                  EditableTextField(
                    controller: _descCtrl,
                    focusNode: _descFocus,
                    hint: 'Notes, details…',
                    onChanged: controller.setDescription,
                    minLines: 3,
                    maxLines: 10, // ensure maxLines >= minLines
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 12)),
                  const SliverToBoxAdapter(child: Divider(height: 1)),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      child: MetaRow(
                        icon: Icons.schedule_outlined,
                        label: 'Created',
                        value: AppDateUtils.formatFullDate(ui.task.createdAt),
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
          data: (ui) => SaveBar(
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

  // You can keep _confirmDelete and _confirmDiscard as before
  // ...
}
