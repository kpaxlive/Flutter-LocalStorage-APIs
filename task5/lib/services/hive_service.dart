import 'package:hive/hive.dart';
import 'package:task_5/screens/models/task_model.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;
  late Box _box;

  HiveService._internal();

  Future init() async {
    _box = await Hive.openBox('todoBox');
  }
  
  Future addTodoItem(String key, TodoModel todo) async {
    await _box.put(key, todo);
  }

  TodoModel? getTodoItem(String key) {
    return _box.get(key);
  }

  Future deleteTodoItem(String key) async {
    await _box.delete(key);
  }

  Future<List> getAllTodoItems() async{
    // ignore: await_only_futures
    return  await _box.values.toList();
  }
}