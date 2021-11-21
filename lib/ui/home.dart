import 'package:flutter/material.dart';
import 'package:tudulis/ui/components/sidebar.dart';
import 'package:tudulis/ui/sections/all.dart';
import 'package:tudulis/ui/sections/completed.dart';
import 'package:tudulis/ui/sections/important.dart';
import 'package:tudulis/ui/sections/today.dart';
import 'package:tudulis/ui/sections/planned.dart';
import 'package:tudulis/services/theme.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int stackIndex = 0;
  bool _isVisible = true;

  changeStackIndex(int newStackIndex) {
    setState(() {
      stackIndex = newStackIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const SelectableText("Tudu Lis"),
        // TODO Animate sidebar with slide animation
        leading: Tooltip(
          message: "Open Sidebar",
          child: IconButton(
            onPressed: () => setState(() => _isVisible = !_isVisible),
            icon: const Icon(Icons.menu),
            splashRadius: 25.0,
          ),
        ),
        actions: <Widget>[
          Tooltip(
            message: "Toggle Dark Mode",
            child: IconButton(
              onPressed: _themeProvider.toggleTheme,
              icon: Icon(_themeProvider.isDark
                  ? Icons.brightness_3
                  : Icons.brightness_7),
              splashRadius: 25.0,
            ),
          ),
          Tooltip(
            message: "Open Settings",
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
              splashRadius: 25.0,
            ),
          ),
          const SizedBox(width: 10.0),
        ],
      ),
      body: Row(
        children: [
          Visibility(
            child: Sidebar(changeIndex: changeStackIndex),
            visible: _isVisible,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: IndexedStack(
                index: stackIndex,
                children: const <Widget>[
                  AllSection(),
                  TodaySection(),
                  ImportantSection(),
                  PlannedSection(),
                  CompletedSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
