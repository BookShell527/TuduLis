import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  Task({
    required this.title,
    required this.note,
    required this.reminder,
    required this.isImportant,
    required this.isCompleted,
    required this.tags,
    this.dueDate,
  });

  @HiveField(0)
  bool isCompleted;

  @HiveField(1)
  String title;

  @HiveField(2)
  String note;

  @HiveField(3)
  List<DateTime> reminder;

  @HiveField(4)
  DateTime? dueDate;

  @HiveField(6)
  bool isImportant;

  @HiveField(7)
  List<String> tags;
}
