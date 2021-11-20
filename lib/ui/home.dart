import 'package:flutter/material.dart';
import 'package:tudulis/ui/components/sidebar.dart';
import 'package:tudulis/ui/sections/all.dart';
import 'package:tudulis/ui/sections/today.dart';
import 'package:tudulis/ui/sections/planned.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int stackIndex = 0;

  changeStackIndex(int newStackIndex) {
    setState(() {
      stackIndex = newStackIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Tudu Lis"),
        leading: Tooltip(
          message: "Open Sidebar",
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
            splashRadius: 25.0,
          ),
        ),
        actions: <Widget>[
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
          Sidebar(changeIndex: changeStackIndex),
          Expanded(
            child: IndexedStack(
              index: stackIndex,
              children: const <Widget>[
                AllSection(),
                TodaySection(),
                PlannedSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
