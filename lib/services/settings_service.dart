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

  // Sidebar dense
  bool _isDense = false;
  bool get isDense => _isDense;
  void toggleDense() async {
    _isDense = !_isDense;
    notifyListeners();
  }

  // Language
  String _langCode = _pref.getString("langCode") ?? "en";
  String get langCode => _langCode;
  void setLangCode(String newLangCode) async {
    _langCode = newLangCode;
    notifyListeners();
    await _pref.setString("langCode", _langCode);
  }

  // Completed task position
  bool _isCompletedBelow = _pref.getBool("isCompletedBelow") ?? true;
  bool get isCompletedBelow => _isCompletedBelow;
  void toggleCompletedBelow() async {
    _isCompletedBelow = !_isCompletedBelow;
    notifyListeners();
    await _pref.setBool("isCompletedBelow", _isCompletedBelow);
  }

  // Sort data
  String _sortAll = _pref.getString("sortAll") ?? "Created";
  String _sortImportant = _pref.getString("sortImportant") ?? "Created";
  String _sortToday = _pref.getString("sortToday") ?? "Created";
  String _sortPlanned = _pref.getString("sortPlanned") ?? "Created";

  // I created this function so that i can change every sort value with one function
  // this is not the best way to implement this, if you find a better way, feel free to change it
  void setSectionSort(String section, String sort) async {
    switch (section) {
      case "all":
        _sortAll = sort;
        await _pref.setString("sortAll", _sortAll);
        break;
      case "important":
        _sortImportant= sort;
        await _pref.setString("sortImportant", _sortImportant);
        break;
      case "today":
        _sortToday = sort;
        await _pref.setString("sortToday", _sortToday);
        break;
      case "planned":
        _sortPlanned = sort;
        await _pref.setString("sortPlanned", _sortPlanned);
        break;
    }
    notifyListeners();
  }

  String getSectionSort(String section) {
    switch (section) {
      case "all": return _sortAll;
      case "important": return _sortImportant;
      case "today": return _sortToday;
      case "planned": return _sortPlanned;
    }
    return "Created";
  }

  // Section List
  bool _showImportantSection = _pref.getBool("showImportantSection") ?? true;
  bool _showTodaySection = _pref.getBool("showTodaySection") ?? true;
  bool _showPlannedSection = _pref.getBool("showPlannedSection") ?? true;
  bool _showCompletedSection = _pref.getBool("showCompletedSection") ?? true;

  // get section value with one function
  bool getSection(String section) {
    switch (section) {
      case "important": return _showImportantSection;
      case "today": return _showTodaySection;
      case "planned": return _showPlannedSection;
      case "completed": return _showCompletedSection;
    }
    return true;
  }

  // I created this function so that i can change every section value with one function
  // this is not the best way to implement this, if you find a better way, feel free to change it
  void toggleSection(String section) async {
    switch (section) {
      case "important":
        _showImportantSection = !_showImportantSection;
        await _pref.setBool("showImportantSection", _showImportantSection);
        break;
      case "today":
        _showTodaySection = !_showTodaySection;
        await _pref.setBool("showTodaySection", _showTodaySection);
        break;
      case "planned":
        _showPlannedSection = !_showPlannedSection;
        await _pref.setBool("showPlannedSection", _showPlannedSection);
        break;
      case "completed":
        _showCompletedSection = !_showCompletedSection;
        await _pref.setBool("showCompletedSection", _showCompletedSection);
    }
    notifyListeners();
  }
}
