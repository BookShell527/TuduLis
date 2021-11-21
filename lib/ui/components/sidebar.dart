import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/theme.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key, required this.changeIndex}) : super(key: key);

  final Function changeIndex;

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    // Using animated container so sidebar color change will look more smoothly
    return SizedBox(
      width: 200.0,
      child: Drawer(
        elevation: 0.0,
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.inbox, color: Colors.pink),
              title: const Text("All"),
              onTap: () => widget.changeIndex(0),
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.yellow),
              title: const Text("Important"),
              onTap: () => widget.changeIndex(1),
            ),
            ListTile(
              leading: const Icon(Icons.today, color: Colors.green),
              title: const Text("Today"),
              onTap: () => widget.changeIndex(2),
            ),
            ListTile(
              leading: const Icon(Icons.schedule, color: Colors.cyan),
              title: const Text("Planned"),
              onTap: () => widget.changeIndex(3),
            ),
            ListTile(
              leading: const Icon(Icons.check, color: Colors.blue),
              title: const Text("Completed"),
              onTap: () => widget.changeIndex(4),
            ),
          ],
        ),
      ),
    );
  }
}
