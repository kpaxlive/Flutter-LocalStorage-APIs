import 'package:hive/hive.dart';
import 'package:task_2/models/todo_model.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;
  late Box _box;

  HiveService._internal();

  Future init() async {
    _box = await Hive.openBox('todoBox');
  }

  Future addTodoItem(String key, Todo todo) async {
    await _box.put(key, todo);
  }

  Todo? getTodoItem(String key) {
    return _box.get(key);
  }

  Future deleteTodoItem(String key) async {
    await _box.delete(key);
  }

  List getAllTodoItems() {
    // ignore: await_only_futures
    return _box.values.toList();
  }
}
