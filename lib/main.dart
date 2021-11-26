import 'package:flutter/material.dart';
import 'package:tudulis/objectbox.g.dart';
import 'package:tudulis/services/language_service.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/theme_service.dart';
import 'package:tudulis/models/task.dart';
import 'package:tudulis/my_app.dart';
import 'package:objectbox/objectbox.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Store store = await openStore();
  Box<Task> taskBox = store.box<Task>();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeService>(create: (_) => ThemeService()),
        ChangeNotifierProvider<LanguageService>(
            create: (_) => LanguageService()),
        ChangeNotifierProvider<TaskService>(
          create: (_) => TaskService(taskBox: taskBox),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
