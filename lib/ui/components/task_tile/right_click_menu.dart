import 'package:flutter/material.dart';

class RightClickMenu extends StatelessWidget {
  const RightClickMenu({
    Key? key,
    required this.child,
    required this.items,
  }) : super(key: key);

  final Widget child;
  final List<PopupMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (e) {
        if (e.buttons == 2) {
          double dy = e.position.dy.ceilToDouble();
          double dx = e.position.dx.ceilToDouble();
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(dx, dy, dx, 0),
            items: items,
          );
        }
      },
      child: child,
    );
  }
}
