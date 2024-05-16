import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 2.0),
          onPressed: () {
            // 사이드 바 확장
          },
          icon: SvgPicture.asset(
            "assets/icons/menu.svg",
          ),
        ),
        actions: <Widget>[
          IconButton(
            visualDensity: const VisualDensity(horizontal: -4.0, vertical: 0.0),
            onPressed: () {
              // 찾기
            },
            icon: SvgPicture.asset(
              "assets/icons/search.svg",
            ),
          ),
          IconButton(
            padding: const EdgeInsets.all(0.0),
            onPressed: () {},
            icon: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                const Positioned(
                  child: Text(
                    "19",
                    style: TextStyle(
                      letterSpacing: -1,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // 현재 날짜로 이동
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/today_date.svg",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      // extendBodyBehindAppBar: true,
      body: CalendarType1(),
    );
  }
}

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
