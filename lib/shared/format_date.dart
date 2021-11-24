import 'package:intl/intl.dart';

String formatDate(DateTime dueDate, bool isReminder) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final tomorrow = DateTime(now.year, now.month, now.day + 1);

  final bool isDefault =
      (dueDate.hour == 23 && dueDate.minute == 59) && !isReminder;
  final String hourAndMinute =
      isDefault ? "" : DateFormat(" H:mm").format(dueDate);
  if (dueDate.day == tomorrow.day) {
    return "Tomorrow$hourAndMinute";
  } else if (dueDate.day == yesterday.day) {
    return "Yesterday$hourAndMinute";
  } else if (dueDate.day == today.day) {
    return "Today$hourAndMinute";
  } else {
    return DateFormat(isDefault ? "EEE, d MMM y" : "H:mm EEE, d MMM y")
        .format(dueDate);
  }
}
