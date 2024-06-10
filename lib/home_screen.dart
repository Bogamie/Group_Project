// home_screen.dart
import 'package:flutter/material.dart';
import 'package:group_project_calendar/schedule_form.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color _fabColor = Colors.grey;
  DateTime _firstDate = DateTime.now().subtract(Duration(days: 30));
  DateTime _lastDate = DateTime.now().add(Duration(days: 30));
  dp.DatePeriod _selectedPeriod = dp.DatePeriod(DateTime.now().subtract(Duration(days: 5)), DateTime.now().add(Duration(days: 5)));

  void _showOverlay(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        double width = MediaQuery.of(context).size.width * 0.90; // 화면 너비의 90%
        double height = MediaQuery.of(context).size.height * 0.90; // 화면 높이의 90%
        double statusBarHeight = MediaQuery.of(context).padding.top; // 상태바 높이

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double viewInsets = MediaQuery.of(context).viewInsets.bottom; // 키보드 높이

            return Padding(
              padding: EdgeInsets.only(top: statusBarHeight),
              child: Align(
                alignment: Alignment.topCenter,
                child: ClipSmoothRect(
                  radius: SmoothBorderRadius(
                    cornerRadius: 20,
                    cornerSmoothing: 0.6,
                  ),
                  child: Material(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: width,
                      height: height - viewInsets,
                      color: Colors.white, // 전체 오버레이의 배경색을 흰색으로 설정
                      child: ScheduleForm(
                        fabColor: _fabColor,
                        firstDate: _firstDate,
                        lastDate: _lastDate,
                        selectedPeriod: _selectedPeriod,
                        onDateSelected: (newPeriod) {
                          setState(() {
                            _selectedPeriod = newPeriod;
                          });
                        },
                        onColorSelected: (color) {
                          setState(() {
                            _fabColor = color;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar App'),
      ),
      body: Center(
        child: Text('Calendar View Here'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showOverlay(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
