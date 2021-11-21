import 'package:flutter/material.dart';
import 'package:tudulis/ui/home.dart';
import 'package:tudulis/services/theme.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Tudu Lis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        drawerTheme: DrawerThemeData(backgroundColor: Colors.grey[100]),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        drawerTheme: DrawerThemeData(backgroundColor: Colors.grey[900]),
      ),
      debugShowCheckedModeBanner: false,
      themeMode: _themeProvider.theme,
      home: const Home(),
    );
  }
}
