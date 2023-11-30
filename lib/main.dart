import 'package:flutter/material.dart';

import 'others/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: HomeScreen(title: 'My App',),
    );
  }
}



