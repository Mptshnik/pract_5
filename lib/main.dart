import 'package:flutter/material.dart';
import 'package:pract_5/first_page.dart';
import 'package:pract_5/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared preferences',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
   //  home: FirstPage(),
      initialRoute: 'first_page',
      routes: {
        'first_page': (context) => FirstPage(),
        'second_page': (context) => SecondPage(),
      },
    );
  }
}
