import 'package:flutter/material.dart';

// if this function is called for reminder, hour and minute will be always included
Future<DateTime?> getDate(BuildContext context, {bool? isReminder}) async {
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
    initialTime: (isReminder ?? false)
        ? TimeOfDay.now()
        : const TimeOfDay(hour: 23, minute: 59),
  );
  DateTime? dateAndTime = date.add(Duration(
    hours: time?.hour ?? 0,
    minutes: time?.minute ?? 0,
  ));

  return dateAndTime;
}
