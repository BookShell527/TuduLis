import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tudulis/ui/components/settings/sections/appearances.dart';
import 'package:tudulis/ui/components/settings/sections/general.dart';
import 'package:tudulis/shared/keyset.dart';

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

    final List<List> sectionData = [
      [_localizations.general, Icons.settings],
      [_localizations.appearances, Icons.palette],
    ];

    return FocusableActionDetector(
      autofocus: true,
      shortcuts: {
        upSectionKeySet: UpSectionSettings(),
        downSectionKeySet: DownSectionSettings(),
        settingsKeySet: CloseSettings(),
      },
      actions: {
        UpSectionSettings: CallbackAction(onInvoke: (_) {
          if (stackIndex != 0) changeIndex(stackIndex - 1);
        }),
        DownSectionSettings: CallbackAction(onInvoke: (_) {
          if (stackIndex != sectionData.length - 1) {
            changeIndex(stackIndex + 1);
          }
        }),
        CloseSettings: CallbackAction(onInvoke: (_) {
          Navigator.of(context).pop();
        }),
      },
      child: Dialog(
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
                      for (int i = 0; i < sectionData.length; i++)
                        ListTile(
                          title: Text(sectionData[i][0]),
                          onTap: () => changeIndex(i),
                          leading: Icon(sectionData[i][1]),
                          selected: stackIndex == i,
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
      ),
    );
  }
}
