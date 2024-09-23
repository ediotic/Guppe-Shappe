import 'package:flutter/material.dart';
import 'package:guppe_shappe/home.dart';

class GuppeShappe extends StatelessWidget {
  const GuppeShappe({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatting Application',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
