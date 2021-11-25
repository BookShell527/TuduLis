import 'package:flutter/material.dart';
import 'package:tudulis/shared/format_date.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskFormBottom extends StatelessWidget {
  const TaskFormBottom({
    Key? key,
    required this.handleSubmit,
    required this.toggleOpen,
    required this.title,
    required this.reminder,
    required this.dueDate,
    required this.isImportant,
    required this.toggleImportant,
    required this.changeDate,
    this.isUpdate = false,
  }) : super(key: key);

  final void Function() handleSubmit;
  final void Function() toggleOpen;
  final void Function() toggleImportant;
  final void Function(bool) changeDate;
  final String title;
  final DateTime? dueDate;
  final DateTime? reminder;
  final bool isImportant;
  final bool isUpdate;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations _localizations = AppLocalizations.of(context)!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextButton(
          onPressed: title.isEmpty ? null : handleSubmit,
          child: Text(
            isUpdate ? _localizations.updateTask : _localizations.addTask,
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
            dueDate == null
                ? _localizations.dueDate
                : formatDate(context, dueDate!),
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
            reminder == null
                ? _localizations.reminder
                : formatDate(context, reminder!, isReminder: true),
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
            isImportant ? Icons.star : Icons.star_outline,
            color: Colors.blue,
            size: 18.0,
          ),
          splashRadius: 0.1,
          onPressed: toggleImportant,
        ),
        const Spacer(),
        IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.red[300],
            size: 18.0,
          ),
          splashRadius: 0.1,
          onPressed: toggleOpen,
        ),
      ],
    );
  }
}
