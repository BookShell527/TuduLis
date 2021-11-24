import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/theme_service.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({
    Key? key,
    required this.changeIndex,
    required this.index,
  }) : super(key: key);

  final Function changeIndex;
  final int index;

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool isDense = false;

  void toggleDense() => setState(() => isDense = !isDense);

  List<Widget> _buildBottomButton(ThemeService themeService) {
    return [
      IconButton(
        onPressed: themeService.toggleTheme,
        icon:
            Icon(themeService.isDark ? Icons.brightness_3 : Icons.brightness_7),
        splashRadius: 0.1,
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.settings),
        splashRadius: 0.1,
      ),
      if (!isDense) const Spacer(),
      IconButton(
        onPressed: toggleDense,
        icon: Icon(!isDense ? Icons.arrow_left : Icons.arrow_right),
        splashRadius: 0.1,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    ThemeService _themeService = Provider.of<ThemeService>(context);
    // TODO pls animate this

    Map<int, List> _tileList = {
      0: [Icons.inbox, Colors.pink, "All"],
      1: [Icons.star, Colors.yellow, "Important"],
      2: [Icons.today, Colors.green[300], "Today"],
      3: [Icons.schedule, Colors.cyan, "Scheduled"],
      4: [Icons.check, Colors.blue, "Completed"],
    };

    return SizedBox(
      width: isDense ? 55.0 : 200.0,
      child: Drawer(
        elevation: 0.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ..._tileList.entries.map((e) {
              return ListTile(
                leading: Icon(e.value[0], color: e.value[1]),
                title: isDense ? null : Text(e.value[2]),
                onTap: () => widget.changeIndex(e.key),
                selected: widget.index == e.key,
              );
            }).toList(),
            const Spacer(),
            isDense
                ? Column(children: _buildBottomButton(_themeService))
                : Row(children: _buildBottomButton(_themeService)),
          ],
        ),
      ),
    );
  }
}
