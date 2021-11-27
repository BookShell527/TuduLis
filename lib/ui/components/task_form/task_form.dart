import 'package:flutter/material.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/shared/date_picker.dart';
import 'package:tudulis/shared/checkbox_color.dart';
import 'package:tudulis/ui/components/task_form/task_form_bottom.dart';
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
  late final TextEditingController titleController;
  late final TextEditingController noteController;

  void changeDate(bool isReminder) async {
    DateTime? date = await getDate(context, isReminder: isReminder);
    isReminder
        ? setState(() => widget.reminder = date)
        : setState(() => widget.dueDate = date);
  }

  void toggleImportant() {
    setState(() => widget.isImportant = !widget.isImportant);
  }

  @override
  void initState() {
    titleController = TextEditingController(text: widget.title);
    noteController = TextEditingController(text: widget.note);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TaskService _taskService = Provider.of<TaskService>(context);
    final AppLocalizations _localizations = AppLocalizations.of(context)!;

    void _handleSubmit() {
      _taskService.putTask(
        id: widget.id,
        title: titleController.text,
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
            fillColor: checkboxColor,
            onChanged: (val) => setState(() => widget.isCompleted = val!),
            splashRadius: 0.1,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: _inputDecoration.copyWith(
                    hintText: _localizations.title,
                  ),
                  autofocus: true,
                  controller: titleController,
                ),
                TextFormField(
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
                TaskFormBottom(
                  handleSubmit: _handleSubmit,
                  toggleOpen: widget.toggleOpen!,
                  title: widget.title,
                  reminder: widget.reminder,
                  dueDate: widget.dueDate,
                  isImportant: widget.isImportant,
                  toggleImportant: toggleImportant,
                  changeDate: changeDate,
                  isUpdate: widget.id != 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
