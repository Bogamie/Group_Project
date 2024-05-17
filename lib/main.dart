import 'package:flutter/material.dart';
import 'package:group_project_calendar/reuse_element.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TopMenu(),
      // extendBodyBehindAppBar: true,
      // body: CalendarType1(),
    );
  }
}

/*
class CalendarType1 extends StatelessWidget {
  List<String> _weekList = ['일', '월', '화', '수', '목', '금', '토'];

  void printWeek() {
    return Container(

    )
  }
  @override
  Widget build(BuildContext context) {
    return Column(

    );
  }
}
*/
