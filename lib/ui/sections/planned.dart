import 'package:flutter/material.dart';

class PlannedSection extends StatefulWidget {
  const PlannedSection({Key? key}) : super(key: key);

  @override
  _PlannedSectionState createState() => _PlannedSectionState();
}

class _PlannedSectionState extends State<PlannedSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("All"),
          ],
        ),
      ],
    );
  }
}
