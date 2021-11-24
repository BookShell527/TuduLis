import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReminderDialog extends StatelessWidget {
  const ReminderDialog({
    Key? key,
    required this.deleteReminder,
    required this.addReminder,
    required this.reminder,
    required this.setState,
  }) : super(key: key);

  final List<String> reminder;
  final Function(Function) addReminder;
  final Function(String, Function) deleteReminder;
  final Function setState;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 350.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
              child: Row(
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
            ),
            for (var reminder in reminder)
              ListTile(
                title: Text(
                  DateFormat("H:mm EEE, d MMM y")
                      .format(DateTime.parse(reminder)),
                ),
                leading: const Icon(Icons.alarm),
                trailing: IconButton(
                  splashRadius: 0.1,
                  icon: Icon(Icons.delete, color: Colors.red[300]),
                  onPressed: () => deleteReminder(reminder, setState),
                ),
              ),
            const Divider(),
            ListTile(
              title: const Text("Add reminder"),
              leading: const Icon(Icons.add),
              onTap: () => addReminder(setState),
            ),
          ],
        ),
      ),
    );
  }
}
