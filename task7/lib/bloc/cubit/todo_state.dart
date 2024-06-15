part of 'todo_cubit.dart';

class TodoState extends Equatable {
  final List<Todo> todos;
  final Filter filter;
  final bool isLoading;
  const TodoState({
    required this.todos,
    required this.filter,
    required this.isLoading,
  });

  TodoState copyWith({
    List<Todo>? todos,
    Filter? filter,
    bool? isLoading,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      filter: filter ?? this.filter,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        todos,
        filter,
      ];
}

enum Filter { all, done, undone }
