import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Open / Close Settings
class OpenSettings extends Intent {}
class CloseSettings extends Intent {}

final settingsKeySet = LogicalKeySet(
  LogicalKeyboardKey.control,
  LogicalKeyboardKey.comma,
);

// Goes up one section
class UpSection extends Intent {}
class UpSectionSettings extends Intent {}

final upSectionKeySet = LogicalKeySet(LogicalKeyboardKey.pageUp);

// Goes down one section
class DownSection extends Intent {}
class DownSectionSettings extends Intent {}

final downSectionKeySet = LogicalKeySet(LogicalKeyboardKey.pageDown);

// Toggle sidebar
class ToggleSidebar extends Intent {}

final toggleSidebarKeySet = LogicalKeySet(LogicalKeyboardKey.keyM);

// Toggle Dark Theme
class ToggleDarkTheme extends Intent {}

final toggleDarkThemeKeySet = LogicalKeySet(
  LogicalKeyboardKey.control,
  LogicalKeyboardKey.keyD,
);
