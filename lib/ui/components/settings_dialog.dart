import 'package:flutter/material.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 250.0,
            child: Drawer(
              elevation: 0.0,
              child: Column(
                children: <Widget>[
                  const ListTile(
                    title: Text(
                      "Settings",
                      style: TextStyle(color: Colors.white, fontSize: 24.0),
                    ),
                  ),
                  ListTile(
                    title: const Text("General"),
                    onTap: () {},
                    leading: const Icon(Icons.settings),
                  ),
                  ListTile(
                    title: const Text("Appearances"),
                    onTap: () {},
                    leading: const Icon(Icons.palette),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: IndexedStack(),
            ),
          ),
        ],
      ),
    );
  }
}
