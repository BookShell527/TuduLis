import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/settings_service.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tudulis/ui/components/settings/settings_dialog.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    Key? key,
    required this.changeIndex,
    required this.index,
  }) : super(key: key);

  final Function changeIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    TaskService _task = Provider.of<TaskService>(context);
    SettingsService _settings = Provider.of<SettingsService>(context);
    AppLocalizations _locale = AppLocalizations.of(context)!;

    final List<List> data = [
      [Icons.inbox, Colors.pink, _locale.allSect, _task.getAll],
      if (_settings.getSection("important"))
        [Icons.star, Colors.yellow, _locale.importantSect, _task.getImportant],
      if (_settings.getSection("today"))
        [Icons.today, Colors.green[300], _locale.todaySect, _task.getToday],
      if (_settings.getSection("planned"))
        [Icons.schedule, Colors.cyan, _locale.plannedSect, _task.getPlanned],
      if (_settings.getSection("completed"))
        [Icons.check, Colors.blue, _locale.completedSect, _task.getCompleted],
    ];

    return SizedBox(
      width: _settings.isDense ? 55.0 : 200.0,
      child: Drawer(
        elevation: 0.0,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: _settings.isDense
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.end,
          children: <Widget>[
            for (int i = 0; i < data.length; i++)
              ListTile(
                leading: Icon(data[i][0], color: data[i][1]),
                title: _settings.isDense ? null : Text(data[i][2]),
                trailing: _settings.isDense || data[i][3].isEmpty
                    ? null
                    : Text(data[i][3].length.toString()),
                onTap: () => changeIndex(i),
                selected: index == i,
              ),
            const Spacer(),
            Wrap(
              children: <Widget>[
                IconButton(
                  onPressed: _settings.toggleTheme,
                  tooltip: _locale.toggleDarkTooltip,
                  icon: Icon(
                    _settings.isDark ? Icons.brightness_3 : Icons.brightness_7,
                  ),
                  splashRadius: 0.1,
                ),
                IconButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => const SettingsDialog(),
                  ),
                  icon: const Icon(Icons.settings),
                  tooltip: _locale.settingsTooltip,
                  splashRadius: 0.1,
                ),
                if (!_settings.isDense) const Spacer(),
                IconButton(
                  tooltip: _settings.isDense
                      ? _locale.maximizeSidebarTooltip
                      : _locale.minimizeSidebarTooltip,
                  onPressed: _settings.toggleDense,
                  icon: Icon(
                    _settings.isDense ? Icons.arrow_right : Icons.arrow_left,
                  ),
                  splashRadius: 0.1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
