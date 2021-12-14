import 'package:flutter/material.dart';
import 'package:tudulis/shared/format_language_code.dart';
import 'package:tudulis/ui/components/settings/settings_title.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tudulis/services/settings_service.dart';

class GeneralSection extends StatelessWidget {
  const GeneralSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations _localizations = AppLocalizations.of(context)!;
    SettingsService _settingsService = Provider.of<SettingsService>(context);

    final List<List<String>> sectionSettingsData = [
      ["important", _localizations.importantSect],
      ["today", _localizations.todaySect],
      ["planned", _localizations.plannedSect],
      ["completed", _localizations.completedSect]
    ];
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SettingsTitle(title: _localizations.general),
          const SizedBox(height: 5.0),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text(_localizations.language),
                  trailing: DropdownButton(
                    value: _localizations.localeName,
                    underline: const SizedBox(),
                    focusColor: Colors.transparent,
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
                ExpansionTile(
                  title: Text(_localizations.section),
                  initiallyExpanded: true,
                  textColor: Colors.white,
                  iconColor: Colors.grey[400],
                  children: sectionSettingsData.map((m) {
                    return SwitchListTile(
                      title: Text(m[1], style: const TextStyle(fontSize: 14.0)),
                      dense: true,
                      value: _settingsService.getSection(m[0]),
                      activeColor: _settingsService.accentColor,
                      onChanged: (_) => _settingsService.toggleSection(m[0]),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
