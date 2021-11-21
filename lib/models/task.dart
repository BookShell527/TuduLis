import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  Task({
    required this.title,
    required this.note,
    required this.reminder,
    required this.dueDate,
    required this.isImportant,
    required this.isCompleted,
    required this.tags,
  });

  @HiveField(0)
  String id = const Uuid().v4();

  @HiveField(1)
  String title;

  @HiveField(2)
  String note;

  @HiveField(3)
  List<DateTime> reminder;

  @HiveField(4)
  DateTime dueDate;

  @HiveField(6)
  bool isImportant;

  @HiveField(7)
  bool isCompleted;

  @HiveField(8)
  List<String> tags;
}
