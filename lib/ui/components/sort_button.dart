import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SortButton extends StatelessWidget {
  const SortButton({
    Key? key,
    required this.changeSort,
    this.isTodaySection = false,
    this.isImportantSection = false,
    this.sort = "Created",
  }) : super(key: key);

  final void Function(String) changeSort;
  final bool isTodaySection;
  final bool isImportantSection;
  final String sort;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations _localizations = AppLocalizations.of(context)!;

    final List<List<String>> _data = [
      ["Created", _localizations.created],
      ["Last Edited", _localizations.lastEdited],
      ["Alphabetically", _localizations.alphabetically],
      if (!isImportantSection) ["Important", _localizations.important],
      if (!isTodaySection) ["Due date", _localizations.dueDate],
    ];
    return PopupMenuButton(
      icon: const Icon(Icons.sort),
      onSelected: changeSort,
      tooltip: _localizations.sortTaskList,
      itemBuilder: (BuildContext context) {
        return _data.map((e) {
          return PopupMenuItem(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: ListTile(
              title: Text(e[1]),
              mouseCursor: SystemMouseCursors.click,
              selected: sort == e[0],
              selectedTileColor: Colors.grey[700],
              selectedColor: Colors.white,
            ),
            value: e[0],
          );
        }).toList();
      },
    );
  }
}
