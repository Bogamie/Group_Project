import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    ScreenUtil.init(context);
    return Scaffold(
      appBar: const TopMenu(),
      extendBodyBehindAppBar: true,
      body: CalendarType1(),
    );
  }
}

class CalendarType1 extends StatelessWidget {
  CalendarType1({super.key});

  final List<String> _weekList = ['일', '월', '화', '수', '목', '금', '토'];
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 0.055.sh,
        ),
        const Text(
          "5",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 32,
          ),
        ),
        SizedBox(
          height: 0.005.sh,
        ),
        Row(
          children: _weekList
              .asMap()
              .map(
                (index, day) => MapEntry(
                  index,
                  Expanded(
                    child: Container(
                      height: 0.03.sh,
                      padding: const EdgeInsets.only(top: 1, bottom: 1),
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Text(
                        day,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: index == 0
                              ? const Color.fromRGBO(238, 75, 43, 1)
                              : index == 6
                                  ? const Color.fromRGBO(0, 150, 255, 1)
                                  : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .values
              .toList(),
        ),
        Container(
          width: 0.99.sw,
          height: 1,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(229, 229, 229, 1),
            borderRadius: SmoothBorderRadius(
              cornerRadius: 10,
              cornerSmoothing: 0.6
            ),
          ),
        ),
        /*Stack(
          for (row = 0; row < 5; row++)
            for (col = 0; col < 7; col++)
              count == 1 ?
        ),*/
      ],
    );
  }
}
