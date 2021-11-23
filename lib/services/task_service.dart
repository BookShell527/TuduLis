import 'package:hive_flutter/hive_flutter.dart';
import 'package:tudulis/models/task.dart';
import 'package:uuid/uuid.dart';

class TaskService {
  final Box<Task> taskBox = Hive.box<Task>("task");
  final Uuid _uuid = const Uuid();

  void addTask({
    required bool isImportant,
    required bool isCompleted,
    required String title,
    required String note,
    required List<String> tags,
    required List<DateTime> reminder,
    DateTime? dueDate,
  }) async {
    await taskBox.add(Task(
      id: _uuid.v4(),
      isImportant: isImportant,
      title: title,
      note: note,
      tags: tags,
      reminder: reminder,
      isCompleted: isCompleted,
      createdAt: DateTime.now(),
      lastEditedAt: DateTime.now(),
      dueDate: dueDate,
    ));
  }

  void reorderTask(int oldIndex, int newIndex) async {}

  void deleteTask(int index) async {
    await taskBox.deleteAt(index);
  }

  List<Task> get allTask => taskBox.values.toList();
  get listenable => taskBox.listenable();
}
