import 'package:flutter/material.dart';

class ThemeService with ChangeNotifier {
  ThemeMode _theme = ThemeMode.dark;

  ThemeMode get theme => _theme;
  bool get isDark => _theme == ThemeMode.dark;
  toggleTheme() {
    _theme = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
