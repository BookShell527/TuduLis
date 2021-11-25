import 'package:flutter/material.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/shared/date_picker.dart';
import 'package:tudulis/shared/checkbox_color.dart';
import 'package:tudulis/ui/components/task_form/task_form_bottom.dart';
import 'package:tudulis/models/task.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key, required this.toggleOpen, this.task})
      : super(key: key);

  final void Function()? toggleOpen;
  final Task? task;

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  // style related variable
  final InputDecoration _inputDecoration = const InputDecoration(
    isDense: true,
    border: InputBorder.none,
  );

  late bool isImportant;
  late bool isCompleted;
  late String title;
  late String note;
  late DateTime? dueDate;
  late DateTime? reminder;
  late List<String> tags;

  @override
  void initState() {
    super.initState();
    isImportant = widget.task?.isImportant ?? false;
    isCompleted = widget.task?.isCompleted ?? false;
    title = widget.task?.title ?? "";
    note = widget.task?.note ?? "";
    dueDate = widget.task?.dueDate;
    reminder = widget.task?.dueDate;
    tags = widget.task?.tags ?? [];
  }

  void changeDate(bool isReminder) async {
    DateTime? date = await getDate(context, isReminder: isReminder);
    isReminder
        ? setState(() => reminder = date)
        : setState(() => dueDate = date);
  }

  void toggleImportant() async => setState(() => isImportant = !isImportant);

  @override
  Widget build(BuildContext context) {
    final TaskService _taskService = Provider.of<TaskService>(context);

    void _handleSubmit() {
      _taskService.putTask(
        id: widget.task?.id,
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
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            value: isCompleted,
            fillColor: checkboxColor,
            onChanged: (val) => setState(() => isCompleted = val!),
            splashRadius: 0.1,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: _inputDecoration.copyWith(hintText: "Title"),
                  onChanged: (val) => setState(() => title = val),
                  initialValue: title,
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
                  initialValue: note,
                ),
                TaskFormBottom(
                  handleSubmit: _handleSubmit,
                  toggleOpen: widget.toggleOpen!,
                  title: title,
                  reminder: reminder,
                  dueDate: dueDate,
                  isImportant: isImportant,
                  toggleImportant: toggleImportant,
                  changeDate: changeDate,
                  isUpdate: widget.task != null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
