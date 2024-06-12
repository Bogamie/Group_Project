import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddTodoOverlay extends StatefulWidget {
  const AddTodoOverlay({super.key});

  @override
  AddTodoOverlayState createState() => AddTodoOverlayState();
}

class AddTodoOverlayState extends State<AddTodoOverlay> {
  Color _fabColor = Colors.grey;
  final DateTime _firstDate = DateTime.now().subtract(const Duration(days: 30));
  final DateTime _lastDate = DateTime.now().add(const Duration(days: 30));
  dp.DatePeriod _selectedPeriod = dp.DatePeriod(
      DateTime.now().subtract(const Duration(days: 5)),
      DateTime.now().add(const Duration(days: 5)));
  bool _isEndDateEnabled = false;
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy년 M월 d일');
    return formatter.format(date);
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.Hm(); // 24시간 형식
    return format.format(dt);
  }

  void _showDatePicker(BuildContext context, bool isStart) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          padding: const EdgeInsets.all(16.0),
          child: dp.RangePicker(
            selectedPeriod: _selectedPeriod,
            onChanged: (dp.DatePeriod newPeriod) {
              setState(() {
                _selectedPeriod = newPeriod;
              });
              Navigator.pop(context); // 날짜 선택 후 오버레이 닫기
            },
            firstDate: _firstDate,
            lastDate: _lastDate,
            datePickerStyles: dp.DatePickerRangeStyles(
              selectedPeriodLastDecoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              selectedPeriodStartDecoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
              ),
              selectedPeriodMiddleDecoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                shape: BoxShape.rectangle,
              ),
            ),
          ),
        );
      },
    );
  }

  void _showTimePicker(BuildContext context, bool isStart) {
    showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    ).then((pickedTime) {
      if (pickedTime != null) {
        setState(() {
          if (isStart) {
            _startTime = pickedTime;
          } else {
            _endTime = pickedTime;
          }
        });
      }
    });
  }

  void _showColorPickerOverlay(BuildContext context) {
    // 색상 선택 오버레이를 표시하는 코드 추가
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: GridView.count(
            crossAxisCount: 5,
            children: [
              _buildColorOption(context, Colors.red),
              _buildColorOption(context, Colors.green),
              _buildColorOption(context, Colors.blue),
              _buildColorOption(context, Colors.yellow),
              _buildColorOption(context, Colors.orange),
              _buildColorOption(context, Colors.purple),
              _buildColorOption(context, Colors.pink),
              _buildColorOption(context, Colors.brown),
              _buildColorOption(context, Colors.cyan),
              _buildColorOption(context, Colors.lime),
            ],
          ),
        );
      },
    );
  }

  Widget _buildColorOption(BuildContext context, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _fabColor = color;
        });
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = 0.9.sw; // 화면 너비의 90%
    double height = 0.42.sh; // 화면 높이의 90%

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: 25,
          cornerSmoothing: 0.6,
        ),
      ),
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20.0), // 제목과 상단의 간격을 아래로 내림
                      Stack(
                        children: [
                          const TextField(
                            decoration: InputDecoration(
                              hintText: '제목',
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0),
                              // 제목 텍스트 크기 변경
                              contentPadding: EdgeInsets.only(left: 10.0),
                              // 오른쪽으로 이동
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10, // 오른쪽으로 약간 이동
                            top: 10, // 상단으로 약간 이동
                            child: GestureDetector(
                              onTap: () {
                                _showColorPickerOverlay(context);
                              },
                              child: Container(
                                width: 20, // 작은 원형 버튼 크기
                                height: 20, // 작은 원형 버튼 크기
                                decoration: BoxDecoration(
                                  color: _fabColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10), // 제목과 시작 사이의 간격 조정
                      Column(
                        children: [
                          Stack(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft, // 왼쪽 정렬
                                    padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0), // 패딩 조정
                                    child: Text(
                                      '시작',
                                      style: TextStyle(fontSize: 16.0, color: Colors.black), // 시작 텍스트 크기 변경
                                    ),
                                  ),
                                  SizedBox(width: 48),
                                  Container(
                                    height: 40, // 버튼 높이 줄이기
                                    width: 145, // 시작 날짜 선택 버튼 너비 고정
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(4)), // 곡률을 줄여 사각형에 가깝게 설정
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white, // 배경색 흰색
                                        foregroundColor: Colors.black, // 텍스트 색상 검은색
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4), // 곡률을 줄여 사각형에 가깝게 설정
                                        ),
                                        elevation: 0, // 그림자 제거
                                      ),
                                      onPressed: () => _showDatePicker(context, true),
                                      child: Text(
                                        _formatDate(_selectedPeriod.start), // 날짜 형식 변경
                                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 2), // 날짜와 시간 위젯 사이의 간격
                                  Container(
                                    height: 40,
                                    width: 70, // 시작 시간 선택 너비를 줄임
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        elevation: 0,
                                      ),
                                      onPressed: () => _showTimePicker(context, true),
                                      child: Text(
                                        _formatTime(_startTime),
                                        style: TextStyle(fontSize: 13.0, color: Colors.black), // 텍스트 크기 조정
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 0), // 시작과 종료 사이의 간격을 줄임
                          Stack(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft, // 왼쪽 정렬
                                    padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0), // 패딩 조정
                                    child: Text(
                                      '종료',
                                      style: TextStyle(fontSize: 16.0, color: Colors.black), // 종료 텍스트 크기 변경
                                    ),
                                  ),
                                  Positioned(
                                    left: 60, // 체크박스의 위치를 조정
                                    top: 0,
                                    child: Checkbox(
                                      value: _isEndDateEnabled,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isEndDateEnabled = value ?? false;
                                        });
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    left: 100,
                                    top: 0,
                                    child: Container(
                                      height: 40, // 버튼 높이 줄이기
                                      width: 145, // 종료 날짜 선택 버튼 너비 고정
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.all(Radius.circular(4)), // 곡률을 줄여 사각형에 가깝게 설정
                                      ),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white, // 배경색 흰색
                                          foregroundColor: Colors.black, // 텍스트 색상 검은색
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4), // 곡률을 줄여 사각형에 가깝게 설정
                                          ),
                                          elevation: 0, // 그림자 제거
                                        ),
                                        onPressed: _isEndDateEnabled ? () => _showDatePicker(context, false) : null,
                                        child: Text(
                                          _formatDate(_selectedPeriod.end), // 날짜 형식 변경
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: _isEndDateEnabled ? Colors.black : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 2), // 날짜와 시간 위젯 사이의 간격
                                  Container(
                                    height: 40,
                                    width: 70, // 종료 시간 선택 너비를 줄임
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        elevation: 0,
                                      ),
                                      onPressed: _isEndDateEnabled ? () => _showTimePicker(context, false) : null,
                                      child: Text(
                                        _formatTime(_endTime),
                                        style: TextStyle(fontSize: 13.0, color: _isEndDateEnabled ? Colors.black : Colors.grey), // 텍스트 크기 조정
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0, right: 5.0, top: 0.0, bottom: 10.0), // 패딩 조정
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey), // 언더라인 추가
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5), // 요소 간의 간격
                      Stack(
                        children: [
                          const TextField(
                            decoration: InputDecoration(
                              hintText: '카테고리',
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                              // 텍스트 크기 변경
                              contentPadding: EdgeInsets.only(left: 40.0),
                              // 오른쪽으로 이동
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 5, // 오른쪽으로 이동
                            top: 10, // 아이콘의 위치를 적절히 조정
                            child: SvgPicture.asset(
                              'assets/icons/category.svg', // SVG 파일 경로
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5), // 요소 간의 간격
                      Stack(
                        children: [
                          const TextField(
                            decoration: InputDecoration(
                              hintText: '메모',
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                              contentPadding: EdgeInsets.only(left: 40.0),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                          Positioned(
                            left: 5, // 오른쪽으로 이동
                            top: 10, // 아이콘의 위치를 적절히 조정
                            child: SvgPicture.asset(
                              'assets/icons/memo.svg', // SVG 파일 경로
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10), // 마지막 요소와 하단 버튼 사이의 간격
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.black, // 검은색 라인
              height: 1.0, // 라인의 두께
              margin: const EdgeInsets.symmetric(horizontal: 15.0), // 스크롤 영역의 언더라인과 같은 길이로 설정
            ),
            SizedBox(
              height: 50.0, // 고정된 영역의 높이 설정
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      // 배경색 흰색
                      foregroundColor: Colors.black,
                      // 텍스트 색상 검은색
                      shadowColor: Colors.transparent,
                      minimumSize: const Size(150, 40),
                      // 버튼 크기 조정
                      elevation: 0, // 그림자 제거
                    ),
                    child: const Text(
                      '취소',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18), // 텍스트 볼드체 및 크기 증가
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // 이벤트 저장 로직 추가
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      // 배경색 흰색
                      foregroundColor: Colors.black,
                      // 텍스트 색상 검은색
                      shadowColor: Colors.transparent,
                      minimumSize: const Size(150, 40),
                      // 버튼 크기 조정
                      elevation: 0, // 그림자 제거
                    ),
                    child: const Text(
                      '저장',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18), // 텍스트 볼드체 및 크기 증가
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
