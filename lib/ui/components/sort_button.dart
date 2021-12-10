import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SortButton extends StatelessWidget {
  const SortButton({
    Key? key,
    required this.changeSort,
    this.isTodaySection = false,
    this.isImportantSection = false,
  }) : super(key: key);

  final void Function(String) changeSort;
  final bool isTodaySection;
  final bool isImportantSection;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations _localizations = AppLocalizations.of(context)!;
    return PopupMenuButton(
      icon: const Icon(Icons.sort),
      onSelected: changeSort,
      tooltip: _localizations.sortTaskList,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: Text(_localizations.created),
            value: "Created",
          ),
          PopupMenuItem(
            child: Text(_localizations.lastEdited),
            value: "Last Edited",
          ),
          PopupMenuItem(
            child: Text(_localizations.alphabetically),
            value: "Alphabetically",
          ),
          if (!isImportantSection)
            PopupMenuItem(
              child: Text(_localizations.important),
              value: "Important",
            ),
          if (!isTodaySection)
            PopupMenuItem(
              child: Text(_localizations.dueDate),
              value: "Due date",
            ),
        ];
      },
    );
  }
}
