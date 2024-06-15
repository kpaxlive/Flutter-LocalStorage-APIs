import 'package:flutter/material.dart';
import 'package:task_2/bloc/bloc.dart';
import 'package:task_2/bloc/cubit/todo_cubit.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key, required this.todoStore, required this.id});

  final TodoCubit todoStore;
  final String id;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // todoStore.removeTodoAt(id);
      },
      icon: const Icon(
        Icons.delete_outline_rounded,
        size: 28,
        color: Color.fromARGB(255, 98, 119, 215),
      ),
    );
  }
}
