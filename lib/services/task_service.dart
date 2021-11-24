import 'package:flutter/material.dart';
import 'package:tudulis/models/task.dart';
import 'package:tudulis/objectbox.g.dart';
import 'package:uuid/uuid.dart';

class TaskService with ChangeNotifier {
  final Uuid _uuid = const Uuid();
  final Box<Task> taskBox;

  TaskService({required this.taskBox});

  void putTask({
    required bool isImportant,
    required bool isCompleted,
    required String title,
    required String note,
    required List<String> tags,
    DateTime? reminder,
    DateTime? dueDate,
    int? id,
  }) {
    taskBox.put(Task(
      id: id ?? 0,
      uid: _uuid.v4(),
      title: title,
      note: note,
      reminder: reminder,
      isImportant: isImportant,
      isCompleted: isCompleted,
      dueDate: dueDate,
      tags: tags,
      createdAt: DateTime.now(),
      lastEditedAt: DateTime.now(),
    ));
    notifyListeners();
  }

  void toggleCompleted(Task task, bool newValue) {
    task.toggleCompleted(newValue);
    taskBox.put(task);
    notifyListeners();
  }

  void deleteTask(int id) {
    taskBox.remove(id);
    notifyListeners();
  }

  void updateDueDate(Task task, DateTime date) {
    task.updateDueDate(date);
    taskBox.put(task);
    notifyListeners();
  }

  void updateReminder(Task task, DateTime newList) {
    task.updateReminder(newList);
    taskBox.put(task);
    notifyListeners();
  }

  List<Task> get getUncompleted {
    Query<Task> query = taskBox.query(Task_.isCompleted.equals(false)).build();
    return query.find();
  }

  List<Task> get getCompleted {
    Query<Task> query = taskBox.query(Task_.isCompleted.equals(true)).build();
    return query.find();
  }

  List<Task> get getAllTask => taskBox.getAll();
}
