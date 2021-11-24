import 'package:flutter/material.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/shared/format_date.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/shared/date_picker.dart';
import 'package:tudulis/shared/checkbox_color.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    final TaskService _taskService = Provider.of<TaskService>(context);
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
          Theme(
            data: Theme.of(context).copyWith(
              iconTheme: const IconThemeData(size: 18.0),
            ),
            child: Expanded(
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
                        hintText: "Note for this task..."),
                    onChanged: (val) => setState(() => note = val),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextButton(
                        onPressed: title.isEmpty
                            ? null
                            : () {
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
                              },
                        child: const Text("Add task"),
                        style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                        ),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.calendar_today, size: 18.0),
                        style: TextButton.styleFrom(
                          primary: Colors.cyan,
                          splashFactory: NoSplash.splashFactory,
                        ),
                        label: Text(
                          dueDate == null
                              ? "Due date"
                              : formatDate(dueDate!, false),
                        ),
                        onPressed: () async {
                          DateTime? date = await getDate(context, false);
                          setState(() => dueDate = date);
                        },
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          primary: Colors.teal,
                          splashFactory: NoSplash.splashFactory,
                        ),
                        icon: const Icon(Icons.alarm, size: 18.0),
                        label: Text(
                          reminder == null
                              ? "Reminder"
                              : formatDate(reminder!, true),
                        ),
                        onPressed: () async {
                          DateTime? date = await getDate(context, true);
                          setState(() => reminder = date);
                        },
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.tag_sharp, size: 18.0),
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          primary: Colors.red[300],
                          splashFactory: NoSplash.splashFactory,
                        ),
                        label: const Text("Tags"),
                      ),
                      IconButton(
                        icon: Icon(
                          isImportant ? Icons.star : Icons.star_outline,
                          color: Colors.blue,
                          size: 18.0,
                        ),
                        splashRadius: 0.1,
                        onPressed: () {
                          setState(() => isImportant = !isImportant);
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.red[300],
                          size: 18.0,
                        ),
                        splashRadius: 0.1,
                        onPressed: widget.toggleOpen,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
