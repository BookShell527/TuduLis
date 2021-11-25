import 'package:flutter/material.dart';
import 'package:tudulis/models/task.dart';
import 'package:tudulis/ui/components/task_form/task_form.dart';
import 'package:tudulis/ui/components/task_tile/task_tile.dart';

class TaskWrapper extends StatefulWidget {
  const TaskWrapper({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  _TaskWrapperState createState() => _TaskWrapperState();
}

class _TaskWrapperState extends State<TaskWrapper> {
  bool isOpened = false;

  void toggleOpen() => setState(() => isOpened = !isOpened);
  @override
  Widget build(BuildContext context) {
    return isOpened
        ? TaskForm(toggleOpen: toggleOpen, task: widget.task)
        : TaskTile(task: widget.task, toggleOpen: toggleOpen);
  }
}
