import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          elevation: 0,
          title: Text('깃허브 테스트',
            style: TextStyle(fontSize: 24),
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}