import 'package:flutter/material.dart';
import 'package:tudulis/models/task.dart';
import 'package:tudulis/ui/home.dart';
import 'package:tudulis/services/theme_service.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Database stuff here
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>("task");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeService>(create: (_) => ThemeService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      themeMode: Provider.of<ThemeService>(context).theme,
      home: const Home(),
    );
  }
}
