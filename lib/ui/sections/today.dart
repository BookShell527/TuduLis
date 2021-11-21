import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodaySection extends StatefulWidget {
  const TodaySection({Key? key}) : super(key: key);

  @override
  _TodaySectionState createState() => _TodaySectionState();
}

class _TodaySectionState extends State<TodaySection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Text(
              "Today",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        Text(
          DateFormat("EEEE, d MMM y").format(DateTime.now()),
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
