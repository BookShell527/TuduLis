import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key, required this.changeIndex}) : super(key: key);

  final Function changeIndex;

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      child: Drawer(
        elevation: 10.0,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: const Text("All"),
              onTap: () => widget.changeIndex(0),
            ),
            ListTile(
              title: const Text("Today"),
              onTap: () => widget.changeIndex(1),
            ),
            ListTile(
              title: const Text("Planned"),
              onTap: () => widget.changeIndex(2),
            ),
          ],
        ),
      ),
    );
  }
}
