import 'package:flutter/material.dart';
import 'package:task_2/models/user_model.dart';
import 'package:task_2/screens/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService api = ApiService();
  List<UserData> users = [];

  @override
  void initState() {
    super.initState();
    api.getUsers().then((value) => setState(() {
          users = value!.data!;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "USERS",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: ((context, index) {
            final user = users[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.avatar!),
              ),
              title: Text(user.firstName! + user.lastName!),
              subtitle: Text(user.email!),
            );
          })),
    );
  }
}
