import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/settings_service.dart';
import 'package:tudulis/shared/keyset.dart';
import 'package:tudulis/ui/components/settings/settings_dialog.dart';
import 'package:tudulis/ui/components/sidebar.dart';
import 'package:tudulis/ui/sections/all.dart';
import 'package:tudulis/ui/sections/completed.dart';
import 'package:tudulis/ui/sections/important.dart';
import 'package:tudulis/ui/sections/today.dart';
import 'package:tudulis/ui/sections/planned.dart';

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
    final SettingsService _settingsService =
        Provider.of<SettingsService>(context);
    final List<Widget> sectionList = <Widget>[
      const AllSection(),
      if (_settingsService.getSection("important")) const ImportantSection(),
      if (_settingsService.getSection("today")) const TodaySection(),
      if (_settingsService.getSection("planned")) const PlannedSection(),
      if (_settingsService.getSection("completed")) const CompletedSection(),
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
