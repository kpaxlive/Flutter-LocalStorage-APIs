// import 'package:bloc/bloc.dart';
// import 'package:task_2/models/todo_model.dart';
// import 'package:task_2/services/hive_service.dart';

// enum Filter { all, done, undone }

// class TodoListCubit extends Cubit<List<Todo>> {
//   final HiveService _hiveService = HiveService();
//   List<Todo> allItems = [];
//   List<Todo> done = [];
//   List<Todo> undone = [];
//   String lastQuery = '';

//   Filter _currentFilter = Filter.all;

//   TodoListCubit() : super([]) {
//     _init();
//   }

//   Future _init() async {
//     await _hiveService.init();
//     await loadTodos();
//   }

//   Future loadTodos() async {
//     final todoList = await _hiveService.getAllTodoItems();
//     allItems = List<Todo>.from(todoList);
//     updateLists();
//     final List<Todo> filteredTodos = applyFilter();
//     emit(filteredTodos);
//   }

//   void addTodo(String title, String content) {
//     final id = DateTime.now().toIso8601String();
//     final todo = Todo(
//       id: id,
//       title: title,
//       content: content,
//       isDone: false,
//     );

//     allItems.add(todo);
//     updateLists();
//     emit(allItems);
//     searchTodos(lastQuery);
//     _hiveService.addTodoItem(id, todo);
//   }

//   // void removeTodoAt(String id) {
//   //   final index = allItems.indexWhere((item) => item.id == id);
//   //   if (index == -1) return;
//   //   _hiveService.deleteTodoItem(allItems[index].id);
//   //   final List<Todo> updatedTodos = List.from(allItems)..removeAt(index);
//   //   allItems = updatedTodos;
//   //   updateLists();
//   //   searchTodos(lastQuery);
//   // }

//   void removeTodoAt(String id) {
//     final index = allItems.indexWhere((item) => item.id == id);
//     if (index == -1) return;
//     _hiveService.deleteTodoItem(allItems[index].id);
//     final List<Todo> updatedTodos = List.from(allItems)..removeAt(index);
//     allItems = updatedTodos;
//     updateLists();
//     searchTodos(lastQuery);
//   }

//   // void toggleTodoStatus(int index) {
//   //   final Todo todo = state[index];
//   //   final Todo updatedTodo = todo.copyWith(isDone: !todo.isDone);
//   //   final List<Todo> updatedTodos = List.from(state)..[index] = updatedTodo;
//   //   allItems[index] = updatedTodo;
//   //   emit(updatedTodos);
//   //   _hiveService.addTodoItem(updatedTodo.id, updatedTodo);
//   // }

//   void toggleTodoStatus(String id) {
//     final index = allItems.indexWhere((item) => item.id == id);
//     if (index == -1) return; // If no todo is found with the given id, return
//     final Todo todo = allItems[index];
//     final Todo updatedTodo = todo.copyWith(isDone: !todo.isDone);
//     final List<Todo> updatedTodos = List.from(allItems)..[index] = updatedTodo;
//     allItems = updatedTodos;
//     updateLists();
//     searchTodos(lastQuery);
//     _hiveService.addTodoItem(allItems[index].id, allItems[index]);
//   }

//   void updateLists() {
//     done = allItems.where((task) => task.isDone == true).toList();
//     undone = allItems.where((task) => task.isDone == false).toList();
//   }

//   void setFilter(Filter filter) {
//     _currentFilter = filter;
//     emit(applyFilter());
//   }

//   List<Todo> applyFilter() {
//     switch (_currentFilter) {
//       case Filter.all:
//         return allItems;
//       case Filter.done:
//         return done;
//       case Filter.undone:
//         return undone;
//       default:
//         return allItems;
//     }
//   }

//   void searchTodos(String query) {
//     lastQuery = query;
//     final List<Todo> filtered = applyFilter();
//     if (query.isEmpty) {
//       emit(filtered);
//     } else {
//       final searchResult = filtered.where((todo) {
//         final titleLower = todo.title.toLowerCase();
//         final searchLower = query.toLowerCase();
//         return titleLower.contains(searchLower);
//       }).toList();
//       emit(searchResult);
//     }
//   }
// }
