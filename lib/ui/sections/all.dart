import 'package:flutter/material.dart';

class AllSection extends StatefulWidget {
  const AllSection({Key? key}) : super(key: key);

  @override
  _AllSectionState createState() => _AllSectionState();
}

class _AllSectionState extends State<AllSection> {
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
