import 'package:flutter/material.dart';

class SettingsTitle extends StatelessWidget {
  const SettingsTitle({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(title, style: const TextStyle(fontSize: 24.0)),
        const Spacer(),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          splashRadius: 0.1,
          icon: Icon(Icons.close, color: Colors.red[400]),
        ),
      ],
    );
  }
}
