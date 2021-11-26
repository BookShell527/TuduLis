import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tudulis/ui/home.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/language_service.dart';
import 'package:tudulis/services/theme_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LanguageService _languageService = Provider.of<LanguageService>(context);
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
      locale: Locale(_languageService.langCode),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        drawerTheme: DrawerThemeData(backgroundColor: Colors.grey[100]),
        splashColor: Colors.transparent,
        checkboxTheme: const CheckboxThemeData(splashRadius: 0.1),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        drawerTheme: DrawerThemeData(backgroundColor: Colors.grey[900]),
        splashColor: Colors.transparent,
        checkboxTheme: const CheckboxThemeData(splashRadius: 0.1),
      ),
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<ThemeService>(context).theme,
      home: const Home(),
    );
  }
}
