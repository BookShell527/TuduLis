import 'package:flutter/material.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/shared/format_date.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/shared/date_picker.dart';
import 'package:tudulis/shared/checkbox_color.dart';
import 'package:intl/intl.dart';
import 'package:tudulis/ui/components/add_task/form_bottom.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({Key? key, required this.toggleOpen}) : super(key: key);
  final void Function()? toggleOpen;

  @override
  _AddTaskFormState createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  // style related variable
  final InputDecoration _inputDecoration = const InputDecoration(
    isDense: true,
    border: InputBorder.none,
  );

  // form state
  bool isImportant = false;
  bool isCompleted = false;
  String title = "";
  String note = "";
  DateTime? dueDate;
  DateTime? reminder;
  List<String> tags = [];

  void changeDate(bool isReminder) async {
    DateTime? date = await getDate(context, isReminder);
    if (isReminder) {
      setState(() => reminder = date);
    } else {
      setState(() => dueDate = date);
    }
  }

  void toggleImportant() async {
    setState(() => isImportant = !isImportant);
  }

  @override
  Widget build(BuildContext context) {
    final TaskService _taskService = Provider.of<TaskService>(context);

    void _handleSubmit() {
      _taskService.addTask(
        title: title,
        note: note,
        tags: tags,
        dueDate: dueDate,
        reminder: reminder,
        isImportant: isImportant,
        isCompleted: isCompleted,
      );
      widget.toggleOpen!();
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 0.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            value: isCompleted,
            fillColor: checkboxColor,
            onChanged: (val) => setState(() => isCompleted = !isCompleted),
            splashRadius: 0.1,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: _inputDecoration.copyWith(hintText: "Title"),
                  onChanged: (val) => setState(() => title = val),
                ),
                TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: _inputDecoration.copyWith(
                    hintText: "Note for this task...",
                  ),
                  onChanged: (val) => setState(() => note = val),
                ),
                AddTaskFormBottom(
                  handleSubmit: _handleSubmit,
                  toggleOpen: widget.toggleOpen!,
                  title: title,
                  reminder: reminder,
                  dueDate: dueDate,
                  isImportant: isImportant,
                  toggleImportant: toggleImportant,
                  changeDate: changeDate,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
