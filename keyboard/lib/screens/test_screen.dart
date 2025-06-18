import 'package:flutter/material.dart';
import 'package:jboard/screens/keyboard_screen.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jboard - Test Keyboard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const KeyboardScreen(),
    );
  }
} 