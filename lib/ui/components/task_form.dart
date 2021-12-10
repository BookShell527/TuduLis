import 'package:flutter/material.dart';
import 'package:tudulis/shared/format_date.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/services/settings_service.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/shared/date_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//ignore: must_be_immutable
class TaskForm extends StatefulWidget {
  TaskForm({
    Key? key,
    required this.toggleOpen,
    this.id = 0,
    this.isImportant = false,
    this.isCompleted = false,
    this.title = "",
    this.note = "",
    this.dueDate,
    this.reminder,
    this.tags = const [],
  }) : super(key: key);

  final void Function()? toggleOpen;
  int id;
  bool isImportant;
  bool isCompleted;
  String title;
  String note;
  DateTime? dueDate;
  DateTime? reminder;
  List<String> tags;

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  // style related variable
  final InputDecoration _inputDecoration = const InputDecoration(
    isDense: true,
    border: InputBorder.none,
  );

  void changeDate(bool isReminder) async {
    DateTime? date = await getDate(context, isReminder: isReminder);
    isReminder ? setState(() => widget.reminder = date) : setState(() => widget.dueDate = date);
  }

  // text field controller
  late final TextEditingController noteController;

  @override
  void initState() {
    noteController = TextEditingController(text: widget.note);
    super.initState();
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TaskService _taskService = Provider.of<TaskService>(context);
    final SettingsService _settingsService = Provider.of<SettingsService>(context);
    final AppLocalizations _localizations = AppLocalizations.of(context)!;

    void _handleSubmit() {
      _taskService.putTask(
        id: widget.id,
        title: widget.title,
        note: noteController.text,
        tags: widget.tags,
        dueDate: widget.dueDate,
        reminder: widget.reminder,
        isImportant: widget.isImportant,
        isCompleted: widget.isCompleted,
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
            value: widget.isCompleted,
            onChanged: (val) => setState(() => widget.isCompleted = val!),
            splashRadius: 0.1,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: _inputDecoration.copyWith(
                    hintText: _localizations.title,
                  ),
                  autofocus: true,
                  onChanged: (val) => setState(() => widget.title = val),
                ),
                TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: _inputDecoration.copyWith(
                    hintText: _localizations.noteForThisTask,
                  ),
                  controller: noteController,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextButton(
                      onPressed: widget.title.isEmpty ? null : _handleSubmit,
                      child: Text(
                        widget.id != 0 ? _localizations.updateTask : _localizations.addTask,
                      ),
                      style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.calendar_today, size: 18.0),
                      style: TextButton.styleFrom(
                        primary: Colors.cyan,
                        splashFactory: NoSplash.splashFactory,
                      ),
                      label: Text(
                        widget.dueDate == null
                            ? _localizations.dueDate
                            : formatDate(context, widget.dueDate!),
                      ),
                      onPressed: () => changeDate(false),
                    ),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        primary: Colors.teal,
                        splashFactory: NoSplash.splashFactory,
                      ),
                      icon: const Icon(Icons.alarm, size: 18.0),
                      label: Text(
                        widget.reminder == null
                            ? _localizations.reminder
                            : formatDate(context, widget.reminder!, isReminder: true),
                      ),
                      onPressed: () => changeDate(true),
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.tag_sharp, size: 18.0),
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        primary: Colors.red[300],
                        splashFactory: NoSplash.splashFactory,
                      ),
                      label: Text(_localizations.tags),
                    ),
                    IconButton(
                      icon: Icon(
                        widget.isImportant ? Icons.star : Icons.star_outline,
                        color: _settingsService.accentColor,
                        size: 18.0,
                      ),
                      splashRadius: 0.1,
                      onPressed: () => setState(() => widget.isImportant = !widget.isImportant),
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
