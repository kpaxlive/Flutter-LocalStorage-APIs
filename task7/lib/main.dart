import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_2/bloc/bloc.dart';
import 'package:task_2/bloc/cubit/todo_cubit.dart';
import 'package:task_2/models/todo_model.dart';
import 'package:task_2/screens/home_page.dart';
import 'package:task_2/services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TodoAdapter());

  final hiveService = HiveService();
  await hiveService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Bloc",
        home: HomePage(),
      ),
    );
  }
}
