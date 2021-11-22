import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:tudulis/models/task.dart';

class TaskService {
  final Box<Task> taskBox = Hive.box<Task>("task");
  final Uuid _uuid = const Uuid();

  void addTask(Task task) async {
    await taskBox.add(task);
  }

  List<Task> get allTask => taskBox.values.toList();
  get listenable => taskBox.listenable();
}
