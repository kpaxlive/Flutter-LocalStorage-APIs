

import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject
{

  @HiveField(0)
  final String key;

  @HiveField(1)
  bool done;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String content;

  TodoModel({required this.key,required this.done, required this.title, required this.content});
}