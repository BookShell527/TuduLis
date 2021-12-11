import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/ui/home.dart';
import 'package:tudulis/services/settings_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsService _settingsService = Provider.of<SettingsService>(context);
    ThemeData _theme(bool isDark) {
      return ThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.grey[isDark ? 900 : 100],
        ),
        listTileTheme: ListTileThemeData(
          selectedTileColor: Colors.grey[isDark ? 800 : 200],
        ),
        splashColor: Colors.transparent,
        primarySwatch: _settingsService.accentColor,
        switchTheme: const SwitchThemeData(splashRadius: 0.1),
        checkboxTheme: CheckboxThemeData(
          splashRadius: 0.1,
          fillColor: MaterialStateProperty.resolveWith((states) {
            if (states.any({
              MaterialState.pressed,
              MaterialState.hovered,
              MaterialState.focused,
              MaterialState.selected
            }.contains)) {
              return _settingsService.accentColor;
            }
            return Colors.grey;
          }),
        ),
      );
    }

    return MaterialApp(
      title: 'Tudu Lis',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('id'),
      ],
      locale: Locale(_settingsService.langCode),
      theme: _theme(false),
      darkTheme: _theme(true),
      debugShowCheckedModeBanner: false,
      themeMode: _settingsService.isDark ? ThemeMode.dark : ThemeMode.light,
      home: const Home(),
    );
  }
}
