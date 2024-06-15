import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_2/models/todo_model.dart';
import 'package:task_2/services/hive_service.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit()
      : super(
          const TodoState(
            todos: [],
            filter: Filter.all,
            isLoading: false,
          ),
        );

  final HiveService _hiveService = HiveService();
  TextEditingController searchController = TextEditingController();

  Future _init() async {
    await _hiveService.init();
    await loadTodos();
  }

  Future loadTodos() async {
    emit(state.copyWith(isLoading: true));
    final todoList = _hiveService.getAllTodoItems();
    var allItems = List<Todo>.from(todoList);
    emit(state.copyWith(todos: allItems, isLoading: false));
    // updateLists();
    // final List<Todo> filteredTodos = applyFilter();
    // emit(state.copyWith(filter: filteredTodos));
  }

  void filterList() {
    switch (state.filter) {
      case Filter.all:
        emit(state.copyWith(todos: state.todos));
        break;
      case Filter.done:
        List<Todo> list = state.todos.where((e) => e.isDone == true).toList();
        emit(state.copyWith(todos: list));
        break;
      case Filter.undone:
        List<Todo> list = state.todos.where((e) => e.isDone == false).toList();
        emit(state.copyWith(todos: list));
        break;
      default:
        [];
    }
    print(state.todos);
  }

  // void addTodo(String title, String content) {
  //   final id = DateTime.now().toIso8601String();
  //   final todo = Todo(
  //     id: id,
  //     title: title,
  //     content: content,
  //     isDone: false,
  //   );

  //   allItems.add(todo);
  //   updateLists();
  //   emit(allItems);
  //   searchTodos(lastQuery);
  //   _hiveService.addTodoItem(id, todo);
  // }

  // void removeTodoAt(String id) {
  //   final index = allItems.indexWhere((item) => item.id == id);
  //   if (index == -1) return;
  //   _hiveService.deleteTodoItem(allItems[index].id);
  //   final List<Todo> updatedTodos = List.from(allItems)..removeAt(index);
  //   allItems = updatedTodos;
  //   updateLists();
  //   searchTodos(lastQuery);
  // }

  void toggleTodoStatus(String id) {
    final index = state.todos.indexWhere((item) => item.id == id);
    if (index == -1) return; // If no todo is found with the given id, return
    final Todo todo = state.todos[index];
    final Todo updatedTodo = todo.copyWith(isDone: !todo.isDone);
    final List<Todo> updatedTodos = List.from(state.todos);
    updatedTodos[index] = updatedTodo;
    emit(state.copyWith(todos: updatedTodos));
    _hiveService.addTodoItem(updatedTodos[index].id, updatedTodos[index]);

    filterList();
  }

  // void updateLists() {
  //   done = allItems.where((task) => task.isDone == true).toList();
  //   undone = allItems.where((task) => task.isDone == false).toList();
  // }

  void setFilter(Filter filter) {
    emit(state.copyWith(filter: filter));
  }

  // List<Todo> applyFilter() {
  //   switch (_currentFilter) {
  //     case Filter.all:
  //       return allItems;
  //     case Filter.done:
  //       return done;
  //     case Filter.undone:
  //       return undone;
  //     default:
  //       return allItems;
  //   }
  // }

  void search(String value) {
    List<Todo> newList = [];
    if (value.isEmpty) {
      loadTodos();
      filterList();
    }
    for (var e in state.todos) {
      if (e.title.toLowerCase().contains(value.toLowerCase())) {
        newList.add(e);
      }
    }
    emit(state.copyWith(todos: newList));
  }

  // void searchTodos(String query) {
  //   lastQuery = query;
  //   final List<Todo> filtered = applyFilter();
  //   if (query.isEmpty) {
  //     emit(filtered);
  //   } else {
  //     final searchResult = filtered.where((todo) {
  //       final titleLower = todo.title.toLowerCase();
  //       final searchLower = query.toLowerCase();
  //       return titleLower.contains(searchLower);
  //     }).toList();
  //     emit(searchResult);
  //   }
  // }
}
