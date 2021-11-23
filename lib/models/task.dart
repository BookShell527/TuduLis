import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  Task({
    required this.id,
    required this.title,
    required this.note,
    required this.reminder,
    required this.isImportant,
    required this.isCompleted,
    required this.tags,
    required this.createdAt,
    required this.lastEditedAt,
    this.dueDate,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String note;

  @HiveField(3)
  List<DateTime> reminder;

  @HiveField(4)
  DateTime? dueDate;

  @HiveField(5)
  bool isCompleted;

  @HiveField(6)
  bool isImportant;

  @HiveField(7)
  List<String> tags;

  @HiveField(8)
  DateTime createdAt;

  @HiveField(9)
  DateTime lastEditedAt;
}
