import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/theme_service.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tudulis/ui/components/settings_dialog.dart';

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

  List<Widget> _buildBottomButton(ThemeService themeService) {
    return <Widget>[
      IconButton(
        onPressed: themeService.toggleTheme,
        icon:
            Icon(themeService.isDark ? Icons.brightness_3 : Icons.brightness_7),
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
      if (!isDense) const Spacer(),
      IconButton(
        onPressed: toggleDense,
        icon: Icon(!isDense ? Icons.arrow_left : Icons.arrow_right),
        splashRadius: 0.1,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    ThemeService _themeService = Provider.of<ThemeService>(context);
    TaskService _taskService = Provider.of<TaskService>(context);
    AppLocalizations _localizations = AppLocalizations.of(context)!;
    // TODO pls animate this
    return SizedBox(
      width: isDense ? 55.0 : 200.0,
      child: Drawer(
        elevation: 0.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.inbox, color: Colors.pink),
              title: isDense ? null : Text(_localizations.allSection),
              trailing: Text(_taskService.getAll.length.toString()),
              onTap: () => widget.changeIndex(0),
              selected: widget.index == 0,
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.yellow),
              title: isDense ? null : Text(_localizations.importantSection),
              trailing: Text(_taskService.getImportant.length.toString()),
              onTap: () => widget.changeIndex(1),
              selected: widget.index == 1,
            ),
            ListTile(
              leading: Icon(Icons.today, color: Colors.green[300]),
              title: isDense ? null : Text(_localizations.todaySection),
              trailing: Text(_taskService.getToday.length.toString()),
              onTap: () => widget.changeIndex(2),
              selected: widget.index == 2,
            ),
            ListTile(
              leading: const Icon(Icons.schedule, color: Colors.cyan),
              title: isDense ? null : Text(_localizations.plannedSection),
              trailing: Text(_taskService.getPlanned.length.toString()),
              onTap: () => widget.changeIndex(3),
              selected: widget.index == 3,
            ),
            ListTile(
              leading: const Icon(Icons.check, color: Colors.blue),
              title: isDense ? null : Text(_localizations.completedSection),
              trailing: Text(_taskService.getCompleted.length.toString()),
              onTap: () => widget.changeIndex(4),
              selected: widget.index == 4,
            ),
            const Spacer(),
            isDense
                ? Column(children: _buildBottomButton(_themeService))
                : Row(children: _buildBottomButton(_themeService)),
          ],
        ),
      ),
    );
  }
}
