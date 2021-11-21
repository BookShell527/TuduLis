import 'package:flutter/material.dart';

class ImportantSection extends StatefulWidget {
  const ImportantSection({Key? key}) : super(key: key);

  @override
  _ImportantSectionState createState() => _ImportantSectionState();
}

class _ImportantSectionState extends State<ImportantSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: const <Widget>[
            Text(
              "Important",
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
