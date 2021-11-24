import 'package:flutter/material.dart';

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
    MaterialState.selected,
  };
  if (states.any(interactiveStates.contains)) return Colors.blue;
  return Colors.grey;
}

final MaterialStateProperty<Color> checkboxColor =
    MaterialStateProperty.resolveWith(getColor);
