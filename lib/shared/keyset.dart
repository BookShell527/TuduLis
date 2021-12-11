import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OpenSettings extends Intent {}

final settingsKeySet = LogicalKeySet(
  LogicalKeyboardKey.control,
  LogicalKeyboardKey.comma,
);

class UpSection extends Intent {}

final upSectionKeySet = LogicalKeySet(LogicalKeyboardKey.pageUp);

class DownSection extends Intent {}

final downSectionKeySet = LogicalKeySet(LogicalKeyboardKey.pageDown);

class ToggleSidebar extends Intent {}

final toggleSidebarKeySet = LogicalKeySet(LogicalKeyboardKey.keyM);

class ToggleDarkTheme extends Intent {}

final toggleDarkThemeKeySet = LogicalKeySet(
  LogicalKeyboardKey.control,
  LogicalKeyboardKey.keyD,
);
