import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key, required this.changeIndex}) : super(key: key);

  final Function changeIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      child: Drawer(
        elevation: 0.0,
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.inbox, color: Colors.pink),
              title: const Text("All"),
              onTap: () => changeIndex(0),
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.yellow),
              title: const Text("Important"),
              onTap: () => changeIndex(1),
            ),
            ListTile(
              leading: Icon(Icons.today, color: Colors.green[300]),
              title: const Text("Today"),
              onTap: () => changeIndex(2),
            ),
            ListTile(
              leading: const Icon(Icons.schedule, color: Colors.cyan),
              title: const Text("Planned"),
              onTap: () => changeIndex(3),
            ),
            ListTile(
              leading: const Icon(Icons.check, color: Colors.blue),
              title: const Text("Completed"),
              onTap: () => changeIndex(4),
            ),
          ],
        ),
      ),
    );
  }
}
