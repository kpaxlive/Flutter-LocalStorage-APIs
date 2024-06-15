import 'package:flutter/material.dart';
import 'package:task_3/screens/third_page.dart';
import 'package:task_3/services/api_service.dart';

class PostMethod extends StatefulWidget {
  const PostMethod({super.key});

  @override
  State<PostMethod> createState() => _PostMethodState();
}

class _PostMethodState extends State<PostMethod> {
  ApiService api = ApiService();
  String response = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder:(context) => AuthPage(),)),
        child: Icon(Icons.arrow_circle_right_outlined, size: 40,),
      ),
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text(response)),
              ElevatedButton(
                  onPressed: () async {
                    response = await api.sendPostRequest();
                    setState(() {});
                  },
                  child: const Text("Post Request")),
            ],
          ),
        ),
      ),
    );
  }
}
