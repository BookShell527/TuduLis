import 'package:flutter/material.dart';

class LanguageService with ChangeNotifier {
  String _langCode = "en";

  String get langCode => _langCode;
  set setLangCode(String newLangCode) {
    _langCode = newLangCode;
    notifyListeners();
  }
}
