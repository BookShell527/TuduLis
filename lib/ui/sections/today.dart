import 'package:flutter/material.dart';

class TodaySection extends StatefulWidget {
  const TodaySection({Key? key}) : super(key: key);

  @override
  _TodaySectionState createState() => _TodaySectionState();
}

class _TodaySectionState extends State<TodaySection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("Today"),
          ],
        ),
      ],
    );
  }
}
