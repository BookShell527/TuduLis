import 'package:flutter/material.dart';
import 'package:tudulis/models/task.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/shared/format_date.dart';
import 'package:tudulis/shared/date_picker.dart';

class TaskTileSubtitle extends StatelessWidget {
  const TaskTileSubtitle({
    Key? key,
    required this.task,
    required this.taskService,
  }) : super(key: key);

  final Task task;
  final TaskService taskService;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  if (date != null) taskService.updateDueDate(task, date);
                },
                label: Text(formatDate(context, task.dueDate!)),
                icon: const Icon(
                  Icons.calendar_today,
                  size: 14.0,
                ),
                style: TextButton.styleFrom(
                  primary:
                      isOverdue(task.dueDate!) ? Colors.red[400] : Colors.cyan,
                  splashFactory: NoSplash.splashFactory,
                ),
              ),
            if (task.reminder != null)
              TextButton.icon(
                onPressed: () async {
                  DateTime? date = await getDate(context, isReminder: true);
                  if (date != null) taskService.updateReminder(task, date);
                },
                label: Text(
                  formatDate(context, task.reminder!, isReminder: true),
                ),
                icon: const Icon(Icons.alarm, size: 14.0),
                style: TextButton.styleFrom(
                  primary:
                      isOverdue(task.reminder!) ? Colors.red[400] : Colors.teal,
                  splashFactory: NoSplash.splashFactory,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
