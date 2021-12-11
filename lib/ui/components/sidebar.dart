import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/settings_service.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tudulis/shared/keyset.dart';
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
  Future? _dialog;

  @override
  Widget build(BuildContext context) {
    TaskService _task = Provider.of<TaskService>(context);
    SettingsService _settings = Provider.of<SettingsService>(context);
    AppLocalizations _locale = AppLocalizations.of(context)!;

    final List<List> data = [
      [Icons.inbox, Colors.pink, _locale.allSection, _task.getAll],
      [Icons.star, Colors.yellow, _locale.importantSection, _task.getImportant],
      [Icons.today, Colors.green[300], _locale.todaySection, _task.getToday],
      [Icons.schedule, Colors.cyan, _locale.plannedSection, _task.getPlanned],
      [Icons.check, Colors.blue, _locale.completedSection, _task.getCompleted],
    ];

    List<Widget> _generateBottomWidget() {
      return <Widget>[
        IconButton(
          onPressed: _settings.toggleTheme,
          tooltip: _locale.toggleDarkTooltip,
          icon:
              Icon(_settings.isDark ? Icons.brightness_3 : Icons.brightness_7),
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
        if (!isDense) const Spacer(),
        IconButton(
          tooltip: isDense
              ? _locale.maximizeSidebarTooltip
              : _locale.minimizeSidebarTooltip,
          onPressed: toggleDense,
          icon: Icon(isDense ? Icons.arrow_right : Icons.arrow_left),
          splashRadius: 0.1,
        ),
      ];
    }

    return FocusableActionDetector(
      autofocus: true,
      shortcuts: {
        toggleSidebarKeySet: ToggleSidebar(),
        settingsKeySet: OpenSettings(),
        upSectionKeySet: UpSection(),
        downSectionKeySet: DownSection(),
        toggleDarkThemeKeySet: ToggleDarkTheme(),
      },
      actions: {
        ToggleSidebar: CallbackAction(onInvoke: (_) => toggleDense()),
        ToggleDarkTheme:
            CallbackAction(onInvoke: (_) => _settings.toggleTheme()),
        UpSection: CallbackAction(onInvoke: (_) {
          if (widget.index != 0) widget.changeIndex(widget.index - 1);
        }),
        DownSection: CallbackAction(onInvoke: (_) {
          if (widget.index != data.length - 1) {
            widget.changeIndex(widget.index + 1);
          }
        }),
        OpenSettings: CallbackAction(onInvoke: (_) async {
          if (_dialog == null) {
            _dialog = showDialog(
              context: context,
              builder: (_) => const SettingsDialog(),
            );
            await _dialog;
            _dialog = null;
          }
        }),
      },
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
              isDense
                  ? Column(children: _generateBottomWidget())
                  : Row(children: _generateBottomWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
