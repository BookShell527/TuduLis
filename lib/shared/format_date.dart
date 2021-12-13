import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final DateTime now = DateTime.now();
final DateTime today = DateTime(now.year, now.month, now.day);
final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
final DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);

bool isOverdue(DateTime date) => date.compareTo(today).isNegative;

String formatDate(
  BuildContext context,
  DateTime date, {
  bool isReminder = false,
}) {
  final AppLocalizations localizations = AppLocalizations.of(context)!;

  final bool isDefault = (date.hour == 23 && date.minute == 59) && !isReminder;
  final String hourAndMinute = isDefault
      ? ""
      : DateFormat(" H:mm", localizations.localeName).format(date);

  final String defaultDateFormat = DateFormat(
    (isDefault ? "" : "H:mm ") + "EEE, d MMM y",
    localizations.localeName,
  ).format(date);

  if (date.day == tomorrow.day) {
    return localizations.tomorrow + hourAndMinute;
  } else if (date.day == yesterday.day) {
    return "Overdue, " + localizations.yesterday + hourAndMinute;
  } else if (date.day == today.day) {
    return localizations.today + hourAndMinute;
  }
  return (isOverdue(date) ? "Overdue, " : "") + defaultDateFormat;
}
