import 'package:flutter/material.dart';
import 'package:tudulis/models/task.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/ui/components/task_tile/task_tile_subtitle.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  bool _isWithSubtitle() {
    return task.dueDate != null ||
        task.note.isNotEmpty ||
        task.reminder.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final TaskService _taskService = Provider.of<TaskService>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: task.isCompleted,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        activeColor: Colors.blue,
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
