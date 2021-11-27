import 'package:flutter/material.dart';
import 'package:tudulis/shared/format_language_code.dart';
import 'package:tudulis/ui/components/settings/settings_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/settings_service.dart';

class GeneralSection extends StatefulWidget {
  const GeneralSection({Key? key}) : super(key: key);

  @override
  _GeneralSectionState createState() => _GeneralSectionState();
}

class _GeneralSectionState extends State<GeneralSection> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations _localizations = AppLocalizations.of(context)!;
    SettingsService _settingsService = Provider.of<SettingsService>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SettingsTitle(title: _localizations.general),
        const SizedBox(height: 5.0),
        ListTile(
          title: Text(_localizations.language),
          trailing: DropdownButton(
            value: _localizations.localeName,
            onChanged: (String? val) {
              if (_localizations.localeName != val) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(_localizations.changingTheLanguage),
                    content: Text(_localizations.areYouSure),
                    actions: [
                      TextButton(
                        child: Text(_localizations.no),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: Text(_localizations.yes),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _settingsService.setLangCode(val!);
                        },
                      ),
                    ],
                  ),
                );
              }
            },
            items: AppLocalizations.supportedLocales.map((e) {
              return DropdownMenuItem<String>(
                child: Text(getDisplayLanguage(e.languageCode)),
                value: e.languageCode,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
