import 'package:flutter/material.dart';
import 'package:tudulis/models/task.dart';
import 'package:tudulis/ui/components/task_tile/task_wrapper.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.taskList,
    required this.sort,
  }) : super(key: key);

  final List<Task> taskList;
  final String sort;

  @override
  Widget build(BuildContext context) {
    if (sort == "Created") {
      taskList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else if (sort == "Last Edited") {
      taskList.sort((a, b) => b.lastEditedAt.compareTo(a.lastEditedAt));
    } else if (sort == "Alphabetically") {
      taskList.sort((a, b) {
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      });
    } else if (sort == "Important") {
      taskList.sort((a, b) => b.isImportant ? 1 : -1);
    } else {
      taskList.sort((a, b) {
        if (b.dueDate == null && a.dueDate == null) return 0;
        if (b.dueDate == null) return -1;
        if (a.dueDate == null) return 1;
        return a.dueDate!.compareTo(b.dueDate!);
      });
    }
    taskList.sort((a, b) => a.isCompleted == true ? 1 : -1);

    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: taskList.length,
        itemBuilder: (BuildContext context, int i) => TaskWrapper(task: taskList[i]),
      ),
    );
  }
}
