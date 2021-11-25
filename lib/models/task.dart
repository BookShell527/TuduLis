import 'package:objectbox/objectbox.dart';

@Entity()
class Task {
  Task({
    required this.uid,
    required this.title,
    required this.note,
    required this.isImportant,
    required this.isCompleted,
    required this.tags,
    required this.createdAt,
    required this.lastEditedAt,
    this.reminder,
    this.dueDate,
    this.id = 0,
  });

  int id;

  @Index()
  String uid;

  String title;
  String note;
  bool isImportant;
  bool isCompleted;
  List<String> tags;

  // Objectbox only only support List<String> data type
  // So we need to convert date time to String
  DateTime? reminder;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  @Property(type: PropertyType.date)
  DateTime lastEditedAt;

  @Property(type: PropertyType.date)
  DateTime? dueDate;

  void toggleCompleted(bool newValue) {
    isCompleted = newValue;
    lastEditedAt = DateTime.now();
  }

  void toggleImportant() {
    isImportant = !isImportant;
    lastEditedAt = DateTime.now();
  }

  void updateDueDate(DateTime date) {
    dueDate = date;
    lastEditedAt = DateTime.now();
  }

  void updateReminder(DateTime newReminder) {
    reminder = newReminder;
    lastEditedAt = DateTime.now();
  }
}
