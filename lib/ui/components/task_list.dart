import 'package:flutter/material.dart';
import 'package:tudulis/models/task.dart';
import 'package:tudulis/ui/components/task_tile/task_wrapper.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key, required this.taskList}) : super(key: key);

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: taskList.length,
      itemBuilder: (BuildContext context, int i) =>
          TaskWrapper(task: taskList[i]),
    );
  }
}
