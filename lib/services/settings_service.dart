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

  String _accentColor = _pref.getString("accentColor") ?? "blue";
  MaterialColor get accentColor {
    switch (_accentColor) {
      case "blue":
        return Colors.blue;
      case "red":
        return Colors.red;
      case "green":
        return Colors.green;
      case "yellow":
        return Colors.yellow;
      case "purple":
        return Colors.purple;
      default:
        return Colors.blue;
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

  // Section List
  bool _showImportantSection = _pref.getBool("showImportantSection") ?? true;
  bool _showTodaySection = _pref.getBool("showTodaySection") ?? true;
  bool _showPlannedSection = _pref.getBool("showPlannedSection") ?? true;
  bool _showCompletedSection = _pref.getBool("showCompletedSection") ?? true;

  // get section value with one function
  bool getSection(String section) {
    switch (section) {
      case "important":
        return _showImportantSection;
      case "today":
        return _showTodaySection;
      case "planned":
        return _showPlannedSection;
      case "completed":
        return _showCompletedSection;
    }
    return true;
  }

  // I created this function so that i can change every section value with one function
  // this is not the best way to implement this, if you find a better way, feel free to change it
  void toggleSection(String section) async {
    switch (section) {
      case "important":
        _showImportantSection = !_showImportantSection;
        notifyListeners();
        await _pref.setBool("showImportantSection", _showImportantSection);
        break;
      case "today":
        _showTodaySection = !_showTodaySection;
        notifyListeners();
        await _pref.setBool("showTodaySection", _showTodaySection);
        break;
      case "planned":
        _showPlannedSection = !_showPlannedSection;
        notifyListeners();
        await _pref.setBool("showPlannedSection", _showPlannedSection);
        break;
      case "completed":
        _showCompletedSection = !_showCompletedSection;
        notifyListeners();
        await _pref.setBool("showCompletedSection", _showCompletedSection);
    }
  }
}
