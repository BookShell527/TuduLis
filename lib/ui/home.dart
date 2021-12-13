import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/settings_service.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/shared/keyset.dart';
import 'package:tudulis/ui/components/section.dart';
import 'package:tudulis/ui/components/settings/settings_dialog.dart';
import 'package:tudulis/ui/components/sidebar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int stackIndex = 0;
  void _changeStackIndex(int newIndex) => setState(() => stackIndex = newIndex);
  Future? _dialog;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations _localizations = AppLocalizations.of(context)!;
    final TaskService _taskService = Provider.of<TaskService>(context);
    final SettingsService _settingsService =
        Provider.of<SettingsService>(context);

    final List<Widget> sectionList = <Widget>[
      Section(
        title: _localizations.allSect,
        section: "all",
        taskList: _taskService.getAll,
      ),
      if (_settingsService.getSection("important"))
        Section(
          title: _localizations.importantSect,
          section: "important",
          taskList: _taskService.getImportant,
        ),
      if (_settingsService.getSection("today"))
        Section(
          title: _localizations.todaySect,
          section: "today",
          taskList: _taskService.getToday,
          withDate: true,
        ),
      if (_settingsService.getSection("planned"))
        Section(
          title: _localizations.plannedSect,
          section: "planned",
          taskList: _taskService.getPlanned,
        ),
      if (_settingsService.getSection("completed"))
        Section(
          title: _localizations.completedSect,
          section: "completed",
          taskList: _taskService.getCompleted,
          withSortButton: false,
        ),
    ];

    return FocusableActionDetector(
      autofocus: true,
      shortcuts: {
        settingsKeySet: OpenSettings(),
        upSectionKeySet: UpSection(),
        downSectionKeySet: DownSection(),
        toggleDarkThemeKeySet: ToggleDarkTheme(),
        toggleSidebarKeySet: ToggleSidebar(),
      },
      actions: {
        ToggleDarkTheme: CallbackAction(onInvoke: (_) {
          _settingsService.toggleTheme();
        }),
        UpSection: CallbackAction(onInvoke: (_) {
          if (stackIndex != 0) _changeStackIndex(stackIndex - 1);
        }),
        DownSection: CallbackAction(onInvoke: (_) {
          if (stackIndex != sectionList.length - 1) {
            _changeStackIndex(stackIndex + 1);
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
        ToggleSidebar: CallbackAction(onInvoke: (_) {
          _settingsService.toggleDense();
        }),
      },
      child: Scaffold(
        body: Row(
          children: <Widget>[
            Sidebar(changeIndex: _changeStackIndex, index: stackIndex),
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  scrollbars: false,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: IndexedStack(index: stackIndex, children: sectionList),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
