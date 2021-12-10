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

class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin {
  bool isDense = false;

  void toggleDense() => setState(() => isDense = !isDense);

  @override
  Widget build(BuildContext context) {
    TaskService _taskService = Provider.of<TaskService>(context);
    SettingsService _settingsService = Provider.of<SettingsService>(context);
    AppLocalizations _localizations = AppLocalizations.of(context)!;

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
              ListTile(
                leading: const Icon(Icons.inbox, color: Colors.pink),
                title: isDense ? null : Text(_localizations.allSection),
                trailing: isDense || _taskService.getAll.isEmpty
                    ? null
                    : Text(_taskService.getAll.length.toString()),
                onTap: () => widget.changeIndex(0),
                selected: widget.index == 0,
              ),
              ListTile(
                leading: const Icon(Icons.star, color: Colors.yellow),
                title: isDense ? null : Text(_localizations.importantSection),
                trailing: isDense || _taskService.getImportant.isEmpty
                    ? null
                    : Text(_taskService.getImportant.length.toString()),
                onTap: () => widget.changeIndex(1),
                selected: widget.index == 1,
              ),
              ListTile(
                leading: Icon(Icons.today, color: Colors.green[300]),
                title: isDense ? null : Text(_localizations.todaySection),
                trailing: isDense || _taskService.getToday.isEmpty
                    ? null
                    : Text(_taskService.getToday.length.toString()),
                onTap: () => widget.changeIndex(2),
                selected: widget.index == 2,
              ),
              ListTile(
                leading: const Icon(Icons.schedule, color: Colors.cyan),
                title: isDense ? null : Text(_localizations.plannedSection),
                trailing: isDense || _taskService.getPlanned.isEmpty
                    ? null
                    : Text(_taskService.getPlanned.length.toString()),
                onTap: () => widget.changeIndex(3),
                selected: widget.index == 3,
              ),
              ListTile(
                leading: const Icon(Icons.check, color: Colors.blue),
                title: isDense ? null : Text(_localizations.completedSection),
                trailing: isDense || _taskService.getCompleted.isEmpty
                    ? null
                    : Text(_taskService.getCompleted.length.toString()),
                onTap: () => widget.changeIndex(4),
                selected: widget.index == 4,
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
                    icon: Icon(!isDense ? Icons.arrow_left : Icons.arrow_right),
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
