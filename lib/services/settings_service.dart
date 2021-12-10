import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService with ChangeNotifier {
  static late SharedPreferences _pref;
  static Future init() async {
    _pref = await SharedPreferences.getInstance();
  }

  // Theme
  bool _isDark = _pref.getBool("isDark") ?? true;
  bool get isDark => _isDark;
  void toggleTheme() async {
    _isDark = !_isDark;
    notifyListeners();
    await _pref.setBool("isDark", _isDark);
  }

  String _accentColor =_pref.getString("accentColor") ?? "blue";
  MaterialColor get accentColor {
    switch (_accentColor) {
      case "blue": return Colors.blue;
      case "red": return Colors.red;
      case "green": return Colors.green;
      case "yellow": return Colors.yellow;
      case "purple": return Colors.purple;
      default: return Colors.blue;
    }
  }
  void setAccentColor(String newColor) async {
    _accentColor = newColor;
    notifyListeners();
    await _pref.setString("accentColor", newColor);
  }

  // Language
  String _langCode = _pref.getString("langCode") ?? "en";
  String get langCode => _langCode;
  void setLangCode(String newLangCode) async {
    _langCode = newLangCode;
    notifyListeners();
    await _pref.setString("langCode", _langCode);
  }
}
