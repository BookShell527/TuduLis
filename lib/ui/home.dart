import 'package:flutter/material.dart';
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

  void _changeStackIndex(int newStackIndex) {
    setState(() => stackIndex = newStackIndex);
  }

  final List<Widget> _sections = const <Widget>[
    AllSection(),
    ImportantSection(),
    TodaySection(),
    PlannedSection(),
    CompletedSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(changeIndex: _changeStackIndex, index: stackIndex),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: IndexedStack(
                  index: stackIndex,
                  children: _sections.map((Widget section) {
                    // I put the SingleChlidScrollView here
                    // because otherwise, the child will be centered vertically
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: section,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
