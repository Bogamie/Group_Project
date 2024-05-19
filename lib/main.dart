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
    ScreenUtil.init(context);
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
      extendBodyBehindAppBar: true,
      appBar: const TopMenu(),
      body: Stack(
        children: <Widget>[
          const CalendarUi(),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16, right: 16),
              child: FloatingActionButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                backgroundColor: const Color.fromRGBO(77, 77, 77, 1),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 36.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarUi extends StatefulWidget {
  const CalendarUi({super.key});

  @override
  CalendarUiState createState() => CalendarUiState();
}

class CalendarUiState extends State<CalendarUi> {
  final PageController _controller = PageController(
      initialPage:
          (DateTime.now().year - 1970) * 12 + DateTime.now().month - 1);
  final List<String> _weekList = ['일', '월', '화', '수', '목', '금', '토'];
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(
      (DateTime.now().year - 1970) * 12 + DateTime.now().month - 1);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _currentPage.value = _controller.page!.round();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  int _getWeekCount(int y, int m) {
    return (DateTime(y, m, 1).weekday + DateTime(y, m + 1, 0).day) ~/ 7 + 1;
  }

  Column _getContainer(
      int index, int date, double w, double h, int sD, int doM, double t) {
    return Column(
      children: [
        Container(
          color: Colors.transparent,
          width: w,
          height: h,
          alignment: Alignment.topCenter,
          child: Text(
            "$date",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: index % 7 == 0
                  ? Color.fromRGBO(238, 75, 43, t)
                  : index % 7 == 6
                      ? Color.fromRGBO(0, 150, 255, t)
                      : Color.fromRGBO(0, 0, 0, t),
            ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
      ],
    );
  }

  Column _calenderPrint(int year, int month) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Wrap(
              children: List.generate(
                _getWeekCount(year, month) * 7,
                (index) {
                  int week = _getWeekCount(year, month);
                  double w = 1.sw / 7.0;
                  double h = (0.78.sh - 2 * (week - 1)) / week;
                  int startDay = DateTime(year, month, 1).weekday;
                  int dayOfMonth = DateTime(year, month + 1, 0).day;

                  if (index < startDay) {
                    return _getContainer(
                        index,
                        DateTime(year, month, 0).day + index - startDay + 1,
                        w,
                        h,
                        startDay,
                        dayOfMonth,
                        0.2);
                  } else if (index >= dayOfMonth + startDay) {
                    return _getContainer(
                        index,
                        index - startDay - dayOfMonth + 1,
                        w,
                        h,
                        startDay,
                        dayOfMonth,
                        0.2);
                  } else {
                    return _getContainer(index, index - startDay + 1, w, h,
                        startDay, dayOfMonth, 1.0);
                  }
                },
              ),
            ),
            Wrap(
              children: List.generate(
                _getWeekCount(year, month) - 1,
                (index) {
                  return Column(
                    children: [
                      SizedBox(
                        height:
                            (0.78.sh - 2 * (_getWeekCount(year, month) - 1)) /
                                _getWeekCount(year, month),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 0.99.sw,
                          height: 1,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(229, 229, 229, 1),
                            borderRadius: SmoothBorderRadius(
                              cornerRadius: 10,
                              cornerSmoothing: 0.6,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 0.05.sh,
        ),
        ValueListenableBuilder<int>(
          valueListenable: _currentPage,
          builder: (context, page, child) {
            int year = 1970 + page ~/ 12;
            int month = page % 12 + 1;
            return Column(
              children: <Widget>[
                Text(
                  year == DateTime.now().year ? "$month" : "$year.$month",
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 32,
                  ),
                ),
                SizedBox(
                  height: 0.005.sh,
                ),
              ],
            );
          },
        ),
        Row(
          children: _weekList
              .asMap()
              .map(
                (index, day) => MapEntry(
                  index,
                  Flexible(
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
            borderRadius:
                SmoothBorderRadius(cornerRadius: 10, cornerSmoothing: 0.6),
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: _controller,
            itemBuilder: (_, index) {
              return _calenderPrint(1970 + index ~/ 12, index % 12 + 1);
            },
          ),
        ),
      ],
    );
  }
}
