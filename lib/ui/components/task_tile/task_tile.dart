import 'package:flutter/material.dart';
import 'package:tudulis/models/task.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/services/settings_service.dart';
import 'package:tudulis/ui/components/task_tile/task_tile_subtitle.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
    required this.toggleOpen,
  }) : super(key: key);

  final Task task;
  final Function() toggleOpen;

  bool _isWithSubtitle() {
    return task.dueDate != null ||
        task.note.isNotEmpty ||
        task.reminder != null;
  }

  @override
  Widget build(BuildContext context) {
    final TaskService _taskService = Provider.of<TaskService>(context);
    final SettingsService _settingsService = Provider.of<SettingsService>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: task.isCompleted,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        // activeColor: Colors.blue,
        secondary: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(
                task.isImportant ? Icons.star : Icons.star_outline,
                color: _settingsService.accentColor,
              ),
              splashRadius: 0.1,
              onPressed: () => _taskService.toggleImportant(task),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              splashRadius: 0.1,
              onPressed: toggleOpen,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              splashRadius: 0.1,
              onPressed: () => _taskService.deleteTask(task.id),
            ),
          ],
        ),
        onChanged: (val) {
          _taskService.toggleCompleted(task, val!);
        },
        subtitle: _isWithSubtitle()
            ? TaskTileSubtitle(task: task, taskService: _taskService)
            : null,
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
      ),
    );
  }
}
