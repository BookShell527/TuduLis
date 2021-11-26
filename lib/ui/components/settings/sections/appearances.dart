import 'package:flutter/material.dart';
import 'package:tudulis/ui/components/settings/settings_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tudulis/services/theme_service.dart';
import 'package:provider/provider.dart';

class AppearancesSection extends StatefulWidget {
  const AppearancesSection({Key? key}) : super(key: key);

  @override
  _AppearancesSectionState createState() => _AppearancesSectionState();
}

class _AppearancesSectionState extends State<AppearancesSection> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations _localizations = AppLocalizations.of(context)!;
    final ThemeService _themeService = Provider.of<ThemeService>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SettingsTitle(title: _localizations.appearances),
        const SizedBox(height: 5.0),
        ListTile(
          title: Text(_localizations.themeMode),
          trailing: Switch(
            splashRadius: 0.1,
            activeColor: Colors.blue,
            value: _themeService.isDark,
            onChanged: (bool val) {
              _themeService.theme = val ? ThemeMode.dark : ThemeMode.light;
            },
          ),
        ),
      ],
    );
  }
}
