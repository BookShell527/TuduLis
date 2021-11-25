import 'package:flutter/material.dart';
import 'package:tudulis/ui/components/add_task/button.dart';
import 'package:tudulis/ui/components/task_form/task_form.dart';

class AddTask extends StatefulWidget {
  const AddTask({
    Key? key,
    this.isImportant,
    this.isCompleted,
    this.dueDate,
  }) : super(key: key);
  final bool? isImportant;
  final bool? isCompleted;
  final DateTime? dueDate;

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  bool isOpened = false;
  void toggleOpen() => setState(() => isOpened = !isOpened);

  @override
  Widget build(BuildContext context) {
    return isOpened
        ? TaskForm(
            toggleOpen: toggleOpen,
            isImportant: widget.isImportant ?? false,
            isCompleted: widget.isCompleted ?? false,
            dueDate: widget.dueDate,
          )
        : AddTaskButton(toggleOpen: toggleOpen);
  }
}
