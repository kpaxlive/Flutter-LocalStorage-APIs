import 'package:flutter/material.dart';
import 'package:task_4/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'SQL',
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}
