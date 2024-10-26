import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  String datetime;
  @HiveField(4)
  String startTime;
  @HiveField(5)
  String endTime;
  @HiveField(6)
  int color;
  @HiveField(7)
  bool isComplete;

  TaskModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.datetime,
      required this.startTime,
      required this.endTime,
      required this.color,
      required this.isComplete});
}
