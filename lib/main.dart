import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:group_project_calendar/calender.dart';
import 'package:group_project_calendar/reuse_element.dart';
import 'package:group_project_calendar/menu_bar.dart';
import 'package:group_project_calendar/add_event.dart';
import 'package:group_project_calendar/add_todo.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageNotifier()),
        ChangeNotifierProvider(create: (_) => FabNotifier()),
        ChangeNotifierProvider(create: (_) => SelectNotifier()),
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
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const MainPage(),
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

class FabNotifier extends ChangeNotifier {
  bool _open = false;

  bool get isOpen => _open;

  void toggle() {
    _open = !_open;
    notifyListeners();
  }
}

class SelectNotifier extends ChangeNotifier {
  int _selectedDay = DateTime.now().day;
  Calendar? _selectedCal;

  int get selectedDay => _selectedDay;

  void selectDay(Calendar cal) {
    if (_selectedCal != null) {
      _selectedCal!.isSelect = false;
    }
    _selectedCal = cal;
    _selectedDay = cal.day;
    _selectedCal!.isSelect = true;
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

  void _animatePage(int page) {
    _controller.animateToPage(
      page,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _jumpPage(int page) {
    _controller.jumpToPage(page);
  }

  Color _getColor(int index, double opac) {
    return index % 7 == 0
        ? Color.fromRGBO(238, 75, 43, opac)
        : index % 7 == 6
            ? Color.fromRGBO(0, 150, 255, opac)
            : Color.fromRGBO(0, 0, 0, opac);
  }

  // 월이 몇 주가 있는지 계산
  int _getWeekCount(int y, int m) {
    int count = DateTime(y, m, 1).weekday % 7 + DateTime(y, m + 1, 0).day;
    return (count % 7 == 0) && (count ~/ 7 != 4) ? count ~/ 7 : count ~/ 7 + 1;
  }

  Widget _buildDayContainer({
    required double width,
    required double height,
    required String text,
    Color borderColor = Colors.transparent,
    Color color = Colors.transparent,
    Color textColor = Colors.black,
  }) {
    return Column(
      children: <Widget>[
        Container(
          width: width,
          height: height,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: SmoothBorderRadius(
              cornerRadius: 5,
              cornerSmoothing: 0.6,
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 1.sh / 42,
                width: 1.sh / 42 * 2,
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
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: TopMenu(
        onMoveTo: () => _jumpPage(
            (DateTime.now().year - 1970) * 12 + DateTime.now().month - 1),
      ),
      drawer: Drawer(),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              SizedBox(
                height: 0.04.sh,
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
                                color: _getColor(index, 1),
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
              Expanded(
                child: Consumer<PageNotifier>(
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
                                          (0.79.sh - 2 * (week - 1)) / week;
                                      int startDay =
                                          DateTime(year, month, 1).weekday % 7;
                                      int dayOfMonth =
                                          DateTime(year, month + 1, 0).day;
                                      if (index < startDay % 7) {
                                        return GestureDetector(
                                          onTap: () => _animatePage(page - 1),
                                          child: _buildDayContainer(
                                            width: w,
                                            height: h,
                                            text:
                                                "${DateTime(year, month, 0).day + index - startDay + 1}",
                                            textColor: _getColor(index, 0.2),
                                          ),
                                        );
                                      } else if (index >=
                                          dayOfMonth + startDay) {
                                        return GestureDetector(
                                          onTap: () => _animatePage(page + 1),
                                          child: _buildDayContainer(
                                              width: w,
                                              height: h,
                                              text:
                                                  "${index - startDay - dayOfMonth + 1}",
                                              textColor: _getColor(index, 0.2)),
                                        );
                                      } else {
                                        Calendar cal = Calendar(
                                          year: year,
                                          month: month,
                                          day: index - startDay + 1,
                                        );
                                        return GestureDetector(
                                          onTap: () {
                                            Provider.of<SelectNotifier>(context,
                                                    listen: false)
                                                .selectDay(cal);
                                          },
                                          child: Consumer<SelectNotifier>(
                                            builder:
                                                (context, selection, child) {
                                              return _buildDayContainer(
                                                width: w,
                                                height: h,
                                                text: "${index - startDay + 1}",
                                                borderColor: cal.isSelect
                                                    ? const Color.fromRGBO(
                                                        170, 170, 170, 1)
                                                    : Colors.transparent,
                                                color: cal.isToday
                                                    ? const Color.fromRGBO(
                                                        255, 49, 49, 0.4)
                                                    : Colors.transparent,
                                                textColor:
                                                    _getColor(index, 1.0),
                                              );
                                            },
                                          ),
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
                                            height: (0.79.sh -
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
                                                borderRadius:
                                                    SmoothBorderRadius(
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
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16, right: 16),
              child: SpeedDial(
                icon: Icons.add_rounded,
                activeIcon: Icons.close_rounded,
                // 클릭 후 아이콘
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                overlayOpacity: 0.0,
                spaceBetweenChildren: 10,
                backgroundColor: const Color.fromRGBO(77, 77, 77, 1),
                childrenButtonSize: const Size.fromRadius(30),
                direction: SpeedDialDirection.up,
                children: [
                  SpeedDialChild(
                    child: const Icon(Icons.event_rounded),
                    label: '이벤트',
                    shape: const CircleBorder(),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AddEventOverlay();
                        },
                      );
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.event_available_rounded),
                    label: '할일',
                    shape: const CircleBorder(),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AddTodoOverlay();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
