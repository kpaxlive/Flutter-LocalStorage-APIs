import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: _isVisible,
              child: const Text(
                'Magic View',
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isVisible = false;
                });
              },
              child: const Text('Hide'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isVisible = true;
                });
              },
              child: const Text('Show'),
            ),
          ],
        ),
      ),
    );
  }
}
