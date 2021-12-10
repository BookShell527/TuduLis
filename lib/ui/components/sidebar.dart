import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/settings_service.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tudulis/ui/components/settings/settings_dialog.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({
    Key? key,
    required this.changeIndex,
    required this.index,
  }) : super(key: key);

  final Function changeIndex;
  final int index;

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool isDense = false;
  void toggleDense() => setState(() => isDense = !isDense);

  @override
  Widget build(BuildContext context) {
    TaskService _taskService = Provider.of<TaskService>(context);
    SettingsService _settingsService = Provider.of<SettingsService>(context);
    AppLocalizations _localizations = AppLocalizations.of(context)!;

    final List data = [
      [Icons.inbox, Colors.pink, _localizations.allSection, _taskService.getAll],
      [Icons.star, Colors.yellow, _localizations.importantSection, _taskService.getImportant],
      [Icons.today, Colors.green[300], _localizations.todaySection, _taskService.getToday],
      [Icons.schedule, Colors.cyan, _localizations.plannedSection, _taskService.getPlanned],
      [Icons.check, Colors.blue, _localizations.completedSection, _taskService.getCompleted],
    ];

    return AnimatedSize(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: SizedBox(
        width: isDense ? 55.0 : 200.0,
        child: Drawer(
          elevation: 0.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              for (int i = 0; i < data.length; i++)
                ListTile(
                  leading: Icon(data[i][0], color: data[i][1]),
                  title: isDense ? null : Text(data[i][2]),
                  trailing: isDense || data[i][3].isEmpty
                      ? null
                      : Text(data[i][3].length.toString()),
                  onTap: () => widget.changeIndex(i),
                  selected: widget.index == i,
                ),
              const Spacer(),
              Wrap(
                children: <Widget>[
                  IconButton(
                    onPressed: _settingsService.toggleTheme,
                    icon: Icon(_settingsService.isDark
                        ? Icons.brightness_3
                        : Icons.brightness_7),
                    splashRadius: 0.1,
                  ),
                  IconButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => const SettingsDialog(),
                    ),
                    icon: const Icon(Icons.settings),
                    splashRadius: 0.1,
                  ),
                  IconButton(
                    onPressed: toggleDense,
                    icon: Icon(isDense ? Icons.arrow_right : Icons.arrow_left),
                    splashRadius: 0.1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
