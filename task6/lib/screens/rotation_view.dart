import 'package:flutter/material.dart';

class AnimationSpells extends StatefulWidget {
  @override
  _AnimationSpellsState createState() => _AnimationSpellsState();
}

class _AnimationSpellsState extends State with SingleTickerProviderStateMixin {
  bool _isVisible = true;

  double _rotation = 0;

  double _offset = 0;

  double _size = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Invisibility Spell'),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  },
                  child: Text(_isVisible ? 'Hide' : 'Show'),
                ),
                AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),

                const Text('Rotation Spell'),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _rotation += 0.5;
                    });
                  },
                  child: const Text('Rotate Right'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _rotation -= 0.5;
                    });
                  },
                  child: const Text('Rotate Left'),
                ),
                AnimatedRotation(
                  turns: _rotation,
                  duration: const Duration(seconds: 1),
                  child: Image.asset(
                    'assets/images/weapon.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(height: 20),

                const Text('Movement Spell'),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _offset = _offset == 0 ? 100 : 0;
                    });
                  },
                  child: const Text('Move'),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  transform: Matrix4.translationValues(0, _offset, 0),
                  child: const Text(
                    'Move me!',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(height: 20),

                const Text('Size Spell'),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _size = _size == 100 ? 200 : 100;
                    });
                  },
                  child: const Text('Resize'),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  width: _size,
                  height: _size,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
