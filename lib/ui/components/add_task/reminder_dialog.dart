import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReminderDialog extends StatefulWidget {
  ReminderDialog({
    Key? key,
    required this.getDate,
    required this.changeReminder,
    required this.reminder,
  }) : super(key: key);

  final Future<DateTime?> Function(BuildContext) getDate;
  final void Function(List<DateTime>) changeReminder;
  List<DateTime> reminder;

  @override
  _ReminderDialogState createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<ReminderDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        width: 350.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Text(
                  "Reminder List",
                  style: TextStyle(fontSize: 24.0),
                ),
                const Spacer(),
                IconButton(
                  splashRadius: 0.1,
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close,
                    color: Colors.red[300],
                  ),
                ),
              ],
            ),
            ...widget.reminder.map((e) {
              return ListTile(
                title: Text(DateFormat("H:mm EEE, d MMM y").format(e)),
                leading: const Icon(Icons.alarm),
                trailing: IconButton(
                  splashRadius: 0.1,
                  icon: Icon(Icons.delete, color: Colors.red[300]),
                  onPressed: () {
                    List<DateTime> newReminder =
                        widget.reminder.where((m) => m != e).toList();

                    // TODO this is not the right way to change the value in AddTaskForm()
                    // please change it
                    // this will change the value of reminder in AddTaskForm() widget
                    widget.changeReminder(newReminder);
                    // this will rebuild this dialog
                    setState(() => widget.reminder = newReminder);
                  },
                ),
              );
            }),
            const Divider(),
            ListTile(
              title: const Text("Add reminder"),
              leading: const Icon(Icons.add),
              onTap: () async {
                DateTime? newReminder = await widget.getDate(context);

                if (newReminder == null ||
                    (newReminder.hour == 0 && newReminder.minute == 0)) return;

                // this will change the value of reminder in AddTaskForm() widget
                widget.changeReminder(
                  <DateTime>[...widget.reminder, newReminder],
                );
                // this will rebuild the dialog
                // TODO this is not the most efficient way, please change it
                setState(() {
                  widget.reminder = <DateTime>[...widget.reminder, newReminder];
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
