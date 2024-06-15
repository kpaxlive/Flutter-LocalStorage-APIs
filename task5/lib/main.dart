import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_5/screens/home_page.dart';
import 'package:task_5/screens/models/task_model.dart';
import 'package:task_5/services/hive_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TodoModelAdapter());

  final hiveService = HiveService();
  await hiveService.init();


  runApp( MaterialApp(
    title: "Hive",
    debugShowCheckedModeBanner: false,
    home: HomePage(hiveService: hiveService,),
  ));
}

