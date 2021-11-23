import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tudulis/models/task.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/ui/components/add_task/reminder_dialog.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({Key? key, required this.toggleOpen}) : super(key: key);
  final void Function()? toggleOpen;

  @override
  _AddTaskFormState createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final TaskService _taskService = TaskService();

  // style related variable
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.selected,
    };
    if (states.any(interactiveStates.contains)) return Colors.blue;
    return Colors.grey;
  }

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
  List<DateTime> reminder = [];
  List<String> tags = [];

  // handling form state
  Future<DateTime?> getDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (date == null) return null;

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay.now(),
    );
    DateTime? dateAndTime = date.add(Duration(
      hours: time?.hour ?? 0,
      minutes: time?.minute ?? 0,
    ));

    return dateAndTime;
  }

  void changeReminder(List<DateTime> newReminder) {
    setState(() => reminder = newReminder);
  }

  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            value: isCompleted,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            onChanged: (val) => setState(() => isCompleted = !isCompleted),
            splashRadius: 0.1,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: _inputDecoration.copyWith(hintText: "Title"),
                  onChanged: (val) => setState(() => title = val),
                ),
                TextField(
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
                Row(
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
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
                    ),
                    TextButton.icon(
                      icon: const Icon(
                        Icons.calendar_today,
                        size: 18.0,
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.cyan,
                      ),
                      label: Text(
                        dueDate == null
                            ? "Due date"
                            : DateFormat(
                                (dueDate?.minute == 0 && dueDate?.hour == 0)
                                    ? "EEE, d MMM y"
                                    : "H:mm EEE, d MMM y",
                              ).format(dueDate!),
                      ),
                      onPressed: () async {
                        DateTime? date = await getDate(context);
                        setState(() => dueDate = date);
                      },
                    ),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        primary: Colors.teal,
                      ),
                      icon: const Icon(
                        Icons.alarm,
                        size: 20.0,
                      ),
                      label: const Text("Reminder"),
                      onPressed: () => showDialog(
                        context: context,
                        barrierColor: Colors.transparent,
                        builder: (BuildContext context) => ReminderDialog(
                          getDate: getDate,
                          changeReminder: changeReminder,
                          reminder: reminder,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      icon: const Icon(
                        Icons.tag_sharp,
                        size: 20.0,
                      ),
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        primary: Colors.red[300],
                      ),
                      label: const Text("Tags"),
                    ),
                    IconButton(
                      icon: Icon(
                        isImportant ? Icons.star : Icons.star_outline,
                        size: 20.0,
                        color: Colors.blue,
                      ),
                      splashRadius: 15.0,
                      onPressed: () {
                        setState(() => isImportant = !isImportant);
                      },
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 20.0,
                        color: Colors.red[300],
                      ),
                      splashRadius: 0.1,
                      onPressed: widget.toggleOpen,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
