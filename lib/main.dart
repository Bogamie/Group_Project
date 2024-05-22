import 'package:flutter/material.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_project_calendar/calender.dart';
import 'package:group_project_calendar/reuse_element.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageNotifier()),
      ],
      child: const MyApp(),
    ),
  );
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

class PageNotifier extends ChangeNotifier {
  int _currentPage =
      (DateTime.now().year - 1970) * 12 + DateTime.now().month - 1;

  int get currentPage => _currentPage;

  void updatePage(int page) {
    _currentPage = page;
    notifyListeners();
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final PageController _controller = PageController(
    initialPage: (DateTime.now().year - 1970) * 12 + DateTime.now().month - 1,
  );
  final List<String> _weekList = ['일', '월', '화', '수', '목', '금', '토'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.addListener(() {
        Provider.of<PageNotifier>(context, listen: false)
            .updatePage(_controller.page!.round());
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void animatePage(int page) {
    _controller.animateToPage(
      page,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void jumpPage(int page) {
    _controller.jumpToPage(page);
  }

  // 월이 몇 주가 있는지 계산
  int _getWeekCount(int y, int m) {
    int count = DateTime(y, m, 1).weekday % 7 + DateTime(y, m + 1, 0).day;
    return count % 7 == 0 ? count ~/ 7 : count ~/ 7 + 1;
  }

  Widget _buildDayContainer({
    required double width,
    required double height,
    required String text,
    Color color = Colors.transparent,
    Color textColor = Colors.black,
  }) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.transparent,
          width: width,
          height: height,
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              Container(
                height: 1.sh / 42,
                width: 1.sh / 42,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 5,
                    cornerSmoothing: 0.6,
                  ),
                ),
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 2,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TopMenu(
        onMoveTo: () => jumpPage(
            (DateTime.now().year - 1970) * 12 + DateTime.now().month - 1),
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              SizedBox(
                height: 0.05.sh,
              ),
              Consumer<PageNotifier>(
                builder: (context, notifier, child) {
                  int page = notifier.currentPage;
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
                    ],
                  );
                },
              ),
              SizedBox(
                height: 0.005.sh,
              ),
              // 주 출력
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
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 10,
                    cornerSmoothing: 0.6,
                  ),
                ),
              ),
              Expanded(child: Consumer<PageNotifier>(
                builder: (context, notifier, child) {
                  int page = notifier.currentPage;
                  return PageView.builder(
                    controller: _controller,
                    itemBuilder: (_, index) {
                      int year = 1970 + index ~/ 12;
                      int month = index % 12 + 1;
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
                                    double h =
                                        (0.78.sh - 2 * (week - 1)) / week;
                                    int startDay =
                                        DateTime(year, month, 1).weekday % 7;
                                    int dayOfMonth =
                                        DateTime(year, month + 1, 0).day;
                                    if (index < startDay % 7) {
                                      return GestureDetector(
                                        onTap: () => animatePage(page - 1),
                                        child: _buildDayContainer(
                                          width: w,
                                          height: h,
                                          text:
                                              "${DateTime(year, month, 0).day + index - startDay + 1}",
                                          textColor: index % 7 == 0
                                              ? const Color.fromRGBO(
                                                  238, 75, 43, 0.2)
                                              : index % 7 == 6
                                                  ? const Color.fromRGBO(
                                                      0, 150, 255, 0.2)
                                                  : const Color.fromRGBO(
                                                      0, 0, 0, 0.2),
                                        ),
                                      );
                                    } else if (index >= dayOfMonth + startDay) {
                                      return GestureDetector(
                                        onTap: () => animatePage(page + 1),
                                        child: _buildDayContainer(
                                          width: w,
                                          height: h,
                                          text:
                                              "${index - startDay - dayOfMonth + 1}",
                                          textColor: index % 7 == 0
                                              ? const Color.fromRGBO(
                                                  238, 75, 43, 0.2)
                                              : index % 7 == 6
                                                  ? const Color.fromRGBO(
                                                      0, 150, 255, 0.2)
                                                  : const Color.fromRGBO(
                                                      0, 0, 0, 0.2),
                                        ),
                                      );
                                    } else {
                                      Calendar c = Calendar(
                                          year: year,
                                          month: month,
                                          day: index - startDay + 1);
                                      return _buildDayContainer(
                                        width: w,
                                        height: h,
                                        text: "${index - startDay + 1}",
                                        color: c.isToday
                                            ? const Color.fromRGBO(
                                                255, 49, 49, 0.4)
                                            : Colors.transparent,
                                        textColor: index % 7 == 0
                                            ? const Color.fromRGBO(
                                                238, 75, 43, 1)
                                            : index % 7 == 6
                                                ? const Color.fromRGBO(
                                                    0, 150, 255, 1)
                                                : const Color.fromRGBO(
                                                    0, 0, 0, 1),
                                      );
                                    }
                                  },
                                ),
                              ),
                              Wrap(
                                // 라인 출력
                                children: List.generate(
                                  _getWeekCount(year, month) - 1,
                                  (index) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: (0.78.sh -
                                                  2 *
                                                      (_getWeekCount(
                                                              year, month) -
                                                          1)) /
                                              _getWeekCount(year, month),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            width: 0.99.sw,
                                            height: 1,
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  229, 229, 229, 1),
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
                    },
                  );
                },
              )),
            ],
          ),
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
