import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tudulis/services/settings_service.dart';
import 'package:tudulis/ui/components/settings/settings_title.dart';

class TaskSection extends StatelessWidget {
  const TaskSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations _localizations = AppLocalizations.of(context)!;
    SettingsService _settingsService = Provider.of<SettingsService>(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SettingsTitle(title: _localizations.task),
        const SizedBox(height: 5.0),
        SwitchListTile(
          title: Text(_localizations.placeCompletedInBottom),
            activeColor: _settingsService.accentColor,
            value: _settingsService.isCompletedBelow,
            onChanged: (_) => _settingsService.toggleCompletedBelow(),
        ),
        SwitchListTile(
          activeColor: _settingsService.accentColor,
          value: _settingsService.showDeleteMessage,
          onChanged: (_) => _settingsService.toggleShowDeleteMessage(),
          title: Text(_localizations.showDeleteMessage),
        ),
      ],
    );
  }
}
