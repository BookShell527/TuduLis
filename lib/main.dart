import 'package:flutter/material.dart';
import 'package:tudulis/objectbox.g.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/ui/home.dart';
import 'package:tudulis/services/theme_service.dart';
import 'package:tudulis/models/task.dart';
import 'package:provider/provider.dart';
import 'package:objectbox/objectbox.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Store store = await openStore();
  Box<Task> taskBox = store.box<Task>();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeService>(create: (_) => ThemeService()),
        ChangeNotifierProvider<TaskService>(
            create: (_) => TaskService(taskBox: taskBox)),
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
