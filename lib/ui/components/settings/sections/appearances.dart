import 'package:flutter/material.dart';
import 'package:tudulis/ui/components/settings/settings_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tudulis/services/settings_service.dart';
import 'package:provider/provider.dart';

class AppearancesSection extends StatelessWidget {
  const AppearancesSection({Key? key}) : super(key: key);

  final List<List> accentList = const [
    [Colors.blue,       "blue"],
    [Colors.red,        "red"],
    [Colors.green,      "green"],
    [Colors.yellow,     "yellow"],
    [Colors.purple,     "purple"],
  ];

  @override
  Widget build(BuildContext context) {
    final AppLocalizations _localizations = AppLocalizations.of(context)!;
    final SettingsService _settingsService = Provider.of<SettingsService>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SettingsTitle(title: _localizations.appearances),
        const SizedBox(height: 5.0),
        ListTile(
          title: Text(_localizations.themeMode),
          trailing: Switch(
            splashRadius: 0.1,
            activeColor: _settingsService.accentColor,
            value: _settingsService.isDark,
            onChanged: (bool val) => _settingsService.toggleTheme(),
          ),
        ),
        ListTile(
          title: Text(_localizations.accentColor),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: accentList.map((m) {
              return Container(
                width: 30.0,
                height: 30.0,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  color: m[0],
                  border: _settingsService.accentColor == m[0] 
                    ? Border.all(width: 1.0, color: Colors.white) 
                    : null,
                ),
                child: MaterialButton(
                  hoverColor: Colors.transparent,
                  onPressed: () => _settingsService.setAccentColor(m[1]),
                ),
              );
            }).toList(),
          )
        )
      ],
    );
  }
}
