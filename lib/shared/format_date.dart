import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String formatDate(BuildContext context, dueDate, {bool isReminder = false}) {
  final AppLocalizations localizations = AppLocalizations.of(context)!;

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final tomorrow = DateTime(now.year, now.month, now.day + 1);

  final bool isDefault =
      (dueDate.hour == 23 && dueDate.minute == 59) && !isReminder;
  final String hourAndMinute = isDefault
      ? ""
      : DateFormat(" H:mm", localizations.localeName).format(dueDate);
  if (dueDate.day == tomorrow.day) {
    return localizations.tomorrow + hourAndMinute;
  } else if (dueDate.day == yesterday.day) {
    return localizations.yesterday + hourAndMinute;
  } else if (dueDate.day == today.day) {
    return localizations.today + hourAndMinute;
  } else {
    return DateFormat(
      isDefault ? "EEE, d MMM y" : "H:mm EEE, d MMM y",
      localizations.localeName,
    ).format(dueDate);
  }
}
