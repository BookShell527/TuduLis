import 'package:flutter/material.dart';

class CompletedSection extends StatefulWidget {
  const CompletedSection({Key? key}) : super(key: key);

  @override
  _CompletedSectionState createState() => _CompletedSectionState();
}

class _CompletedSectionState extends State<CompletedSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: const <Widget>[
            Text(
              "Completed",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
