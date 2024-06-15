// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:task_4/models/user_model.dart';
import 'package:task_4/services/database_service.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  DatabaseService db = DatabaseService();
  List<UserData> users = [];

  Future<void> getUsers() async {
    users = await db.getItems();
    print(users.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("User List"),
      ),
      body: FutureBuilder(
        future: getUsers(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              getUsers();
              UserData user = users[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey.shade200,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'ID: ${user.id}, ${user.name} ${user.surname}, ${user.age}',
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.delete_outline_outlined,
                                      size: 35,
                                      color: Colors.red.shade700,
                                    ),
                                    onPressed: () async {
                                      await db.deleteItem(user.id!);
                                      setState(() {});
                                    })
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
