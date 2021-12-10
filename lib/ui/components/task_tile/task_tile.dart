import 'package:flutter/material.dart';
import 'package:tudulis/models/task.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/services/settings_service.dart';
import 'package:tudulis/shared/format_date.dart';
import 'package:tudulis/shared/date_picker.dart';
import 'package:tudulis/ui/components/task_tile/right_click_menu.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
    required this.toggleOpen,
  }) : super(key: key);

  final Task task;
  final Function() toggleOpen;

  @override
  Widget build(BuildContext context) {
    final TaskService _taskService = Provider.of<TaskService>(context);
    final SettingsService _settingsService =
        Provider.of<SettingsService>(context);
    final bool _isWithSubtitle =
        task.dueDate != null || task.note.isNotEmpty || task.reminder != null;
    return RightClickMenu(
      items: <PopupMenuItem>[
        PopupMenuItem(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: const ListTile(
            leading: Icon(Icons.edit),
            title: Text("Edit"),
            mouseCursor: SystemMouseCursors.click,
          ),
          onTap: toggleOpen,
        ),
        PopupMenuItem(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: const ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text("Delete", style: TextStyle(color: Colors.red)),
            mouseCursor: SystemMouseCursors.click,
          ),
          onTap: () => _taskService.deleteTask(task.id),
        ),
      ],
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: task.isCompleted,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          secondary: IconButton(
            icon: Icon(
              task.isImportant ? Icons.star : Icons.star_outline,
              color: _settingsService.accentColor,
            ),
            splashRadius: 0.1,
            onPressed: () => _taskService.toggleImportant(task),
          ),
          onChanged: (val) {
            _taskService.toggleCompleted(task, val!);
          },
          subtitle: !_isWithSubtitle
              ? null
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (task.note.isNotEmpty) Text(task.note),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if (task.dueDate != null)
                          TextButton.icon(
                            onPressed: () async {
                              DateTime? date = await getDate(context);
                              if (date != null) {
                                _taskService.updateDueDate(task, date);
                              }
                            },
                            label: Text(formatDate(context, task.dueDate!)),
                            icon: const Icon(
                              Icons.calendar_today,
                              size: 14.0,
                            ),
                            style: TextButton.styleFrom(
                              primary: isOverdue(task.dueDate!)
                                  ? Colors.red[400]
                                  : Colors.cyan,
                              splashFactory: NoSplash.splashFactory,
                            ),
                          ),
                        if (task.reminder != null)
                          TextButton.icon(
                            onPressed: () async {
                              DateTime? date =
                                  await getDate(context, isReminder: true);
                              if (date != null) {
                                _taskService.updateReminder(task, date);
                              }
                            },
                            label: Text(
                              formatDate(
                                context,
                                task.reminder!,
                                isReminder: true,
                              ),
                            ),
                            icon: const Icon(Icons.alarm, size: 14.0),
                            style: TextButton.styleFrom(
                              primary: isOverdue(task.reminder!)
                                  ? Colors.red[400]
                                  : Colors.teal,
                              splashFactory: NoSplash.splashFactory,
                            ),
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
