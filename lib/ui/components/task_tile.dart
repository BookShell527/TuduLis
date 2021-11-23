import 'package:flutter/material.dart';
import 'package:tudulis/models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
    required this.deleteTask,
  }) : super(key: key);

  final Task? task;
  final void Function() deleteTask;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        trailing: IconButton(
          onPressed: deleteTask,
          icon: const Icon(Icons.delete),
        ),
        leading: Checkbox(
          onChanged: (val) {},
          splashRadius: 0.1,
          value: task?.isCompleted ?? false,
        ),
        title: Text(
          task?.title ?? "",
          style: TextStyle(
            decoration:
                task?.isCompleted ?? false ? TextDecoration.lineThrough : null,
          ),
        ),
      ),
    );
  }
}
