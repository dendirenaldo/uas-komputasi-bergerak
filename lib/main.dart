import 'package:flutter/material.dart';
import 'package:calegmu/main_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'C A L E G M U',
      theme: ThemeData(),
      home: const MainScreen(),
    );
  }
}
