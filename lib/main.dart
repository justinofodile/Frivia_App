import 'package:flutter/material.dart';
import 'package:triviaa/pages/game_page.dart';
import 'package:triviaa/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Frivia Game',
      theme: ThemeData(
        fontFamily: 'ArchitectsDaughter',
        scaffoldBackgroundColor: const Color.fromRGBO(31, 31, 31, 1.0),
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
