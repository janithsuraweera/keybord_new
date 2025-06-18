import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jboard/providers/keyboard_provider.dart';
import 'package:jboard/providers/theme_provider.dart';
import 'package:jboard/screens/test_screen.dart';

void main() {
  runApp(const JboardApp());
}

class JboardApp extends StatelessWidget {
  const JboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KeyboardProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Jboard - Sinhala Keyboard',
            theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: const TestScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
