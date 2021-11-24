import 'package:flutter/material.dart';
import 'package:tudulis/models/task.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/shared/get_formatted_date.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    final TaskService _taskService = Provider.of<TaskService>(context);

    final bool isWithSubtitle = task.dueDate != null ||
        task.note.isNotEmpty ||
        task.reminder.isNotEmpty;

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
        subtitle: isWithSubtitle
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (task.dueDate != null)
                    TextButton.icon(
                      onPressed: () {},
                      label: Text(
                        getDueDate(task.dueDate ?? DateTime.now(), false),
                      ),
                      icon: const Icon(
                        Icons.calendar_today,
                        size: 14.0,
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 8.0,
                        ),
                        primary: Colors.cyan,
                        splashFactory: NoSplash.splashFactory,
                      ),
                    ),
                  if (task.reminder.isNotEmpty)
                    TextButton.icon(
                      onPressed: () {},
                      label: Text(
                        getDueDate(DateTime.parse(task.reminder[0]), true),
                      ),
                      icon: const Icon(
                        Icons.alarm,
                        size: 14.0,
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 8.0,
                        ),
                        primary: Colors.teal,
                        splashFactory: NoSplash.splashFactory,
                      ),
                    )
                ],
              )
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
