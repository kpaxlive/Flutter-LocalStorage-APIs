import 'package:flutter/material.dart';
import 'package:task_3/services/api_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthenticatedDio dio =
      AuthenticatedDio(baseUrl: 'https://reqres.in/api/register');
  String token = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Add authentication reuquests token header"),
            Text("Added token: ${token}"),
            ElevatedButton(
                onPressed: () async {
                  try {
                    await dio.authenticate();
                    token = dio.token;
                    setState(() {});
                    print('Authentication successful');
                  } catch (e) {
                    print('An error occurred: $e');
                  }
                },
                child: const Text("buton"))
          ],
        ),
      ),
    );
  }
}
