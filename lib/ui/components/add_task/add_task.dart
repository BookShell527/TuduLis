import 'package:flutter/material.dart';
import 'package:tudulis/ui/components/add_task/button.dart';
import 'package:tudulis/ui/components/add_task/form.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  bool isOpened = false;

  void toggleOpen() => setState(() => isOpened = !isOpened);

  @override
  Widget build(BuildContext context) {
    return isOpened
        ? AddTaskForm(toggleOpen: toggleOpen)
        : AddTaskButton(toggleOpen: toggleOpen);
  }
}
