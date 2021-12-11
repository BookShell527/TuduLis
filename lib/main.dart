import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/objectbox.g.dart';
import 'package:tudulis/services/settings_service.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/models/task.dart';
import 'package:tudulis/my_app.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SettingsService.init();
  Store store = await openStore();
  Box<Task> taskBox = store.box<Task>();

  setWindowTitle("TuduLis");
  setWindowMinSize(const Size(630, 300));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsService>(
          create: (_) => SettingsService(),
        ),
        ChangeNotifierProvider<TaskService>(
          create: (_) => TaskService(taskBox: taskBox),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
