import 'package:flutter/material.dart';
import 'package:tudulis/ui/components/task_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final AppLocalizations _localizations = AppLocalizations.of(context)!;
    if (isOpened) {
      return TaskForm(
        toggleOpen: toggleOpen,
        isImportant: widget.isImportant ?? false,
        isCompleted: widget.isCompleted ?? false,
        dueDate: widget.dueDate,
      );
    }
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith((states) {
            Set interStates = {MaterialState.pressed};
            if (states.any(interStates.contains)) return Colors.transparent;
          }),
        ),
        icon: const Icon(Icons.add),
        onPressed: toggleOpen,
        label: Text(_localizations.addTask),
      ),
    );
  }
}
