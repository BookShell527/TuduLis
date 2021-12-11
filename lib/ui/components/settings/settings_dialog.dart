import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tudulis/ui/components/settings/sections/appearances.dart';
import 'package:tudulis/ui/components/settings/sections/general.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  int stackIndex = 0;
  void changeIndex(int newIndex) => setState(() => stackIndex = newIndex);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations _localizations = AppLocalizations.of(context)!;
    return Dialog(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 200.0,
            child: Drawer(
              elevation: 0.0,
              child: Theme(
                data: Theme.of(context).copyWith(
                  listTileTheme: const ListTileThemeData(
                    selectedTileColor: null,
                  ),
                ),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        _localizations.settings,
                        style: const TextStyle(fontSize: 24.0),
                      ),
                    ),
                    ListTile(
                      title: Text(_localizations.general),
                      onTap: () => changeIndex(0),
                      leading: const Icon(Icons.settings),
                      selected: stackIndex == 0,
                    ),
                    ListTile(
                      title: Text(_localizations.appearances),
                      onTap: () => changeIndex(1),
                      leading: const Icon(Icons.palette),
                      selected: stackIndex == 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 4.0,
              ),
              child: IndexedStack(
                index: stackIndex,
                children: const <Widget>[
                  GeneralSection(),
                  AppearancesSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
