import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTodoOverlay extends StatefulWidget {
  const AddTodoOverlay({super.key});

  AddTodoOverlayState createState() => AddTodoOverlayState();
}

class AddTodoOverlayState extends State<AddTodoOverlay> {
  Color _fabColor = Colors.grey;
  final DateTime _firstDate = DateTime.now().subtract(const Duration(days: 30));
  final DateTime _lastDate = DateTime.now().add(const Duration(days: 30));
  dp.DatePeriod _selectedPeriod = dp.DatePeriod(
      DateTime.now().subtract(const Duration(days: 5)),
      DateTime.now().add(const Duration(days: 5)));

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
                              hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 18.0),
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
                                // 나중에 색상 선택 오버레이 구현
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
                      const SizedBox(height: 0), // 제목과 시작 사이의 간격 조정
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0), // 전체를 아래로 내림
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  // 왼쪽 정렬
                                  padding: const EdgeInsets.only(
                                      left: 10.0, top: 10.0, bottom: 10.0),
                                  // 패딩 조정
                                  child: const Text(
                                    '시작',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black), // 시작 텍스트 크기 변경
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  height: 40, // 버튼 높이 줄이기
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                            4)), // 곡률을 줄여 사각형에 가깝게 설정
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      // 배경색 흰색
                                      foregroundColor: Colors.black,
                                      // 텍스트 색상 검은색
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            4), // 곡률을 줄여 사각형에 가깝게 설정
                                      ),
                                      elevation: 0, // 그림자 제거
                                    ),
                                    onPressed: () =>
                                        _showDatePicker(context, true),
                                    child: Text(
                                      '${_selectedPeriod.start.toLocal()}'
                                          .split(' ')[0],
                                      style: const TextStyle(
                                          fontSize: 16.0, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 0), // 시작과 종료 사이의 간격을 줄임
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 5.0,
                                      top: 35.0,
                                      bottom: 15.0),
                                  // 패딩 조정
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey), // 언더라인 추가
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft, // 왼쪽 정렬
                                      padding: const EdgeInsets.only(
                                          left: 10.0,
                                          top: 10.0,
                                          bottom: 10.0), // 패딩 조정
                                      child: const Text(
                                        '종료',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color:
                                            Colors.black), // 종료 텍스트 크기 변경
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      height: 40, // 버튼 높이 줄이기
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                                4)), // 곡률을 줄여 사각형에 가깝게 설정
                                      ),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          // 배경색 흰색
                                          foregroundColor: Colors.black,
                                          // 텍스트 색상 검은색
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                4), // 곡률을 줄여 사각형에 가깝게 설정
                                          ),

                                          elevation: 0, // 그림자 제거
                                        ),
                                        onPressed: () =>
                                            _showDatePicker(context, false),
                                        child: Text(
                                          '${_selectedPeriod.end.toLocal()}'
                                              .split(' ')[0],
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5), // 요소 간의 간격
                      Stack(
                        children: [
                          const TextField(
                            decoration: InputDecoration(
                              hintText: '카테고리',
                              hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0),
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
                              hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0),
                              // 텍스트 크기 변경
                              contentPadding: EdgeInsets.only(left: 40.0),
                              // 오른쪽으로 이동
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
              margin: const EdgeInsets.symmetric(
                  horizontal: 15.0), // 스크롤 영역의 언더라인과 같은 길이로 설정
            ),
            Container(
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
