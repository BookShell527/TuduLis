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

  void changeStackIndex(int newStackIndex) {
    setState(() => stackIndex = newStackIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(changeIndex: changeStackIndex, index: stackIndex),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: IndexedStack(
                  index: stackIndex,
                  children: const <Widget>[
                    AllSection(),
                    ImportantSection(),
                    TodaySection(),
                    PlannedSection(),
                    CompletedSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
