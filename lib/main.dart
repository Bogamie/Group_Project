import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

class HomeScreen extends StatelessWidget {
  void _showOverlay(BuildContext context) {
    double customHeight = 800.0; // 원하는 높이로 설정

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        double width = MediaQuery.of(context).size.width * 0.90; // 화면 너비의 90%
        double statusBarHeight = MediaQuery.of(context).padding.top; // 상태바 높이

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double viewInsets = MediaQuery.of(context).viewInsets.bottom; // 키보드 높이

            return Padding(
              padding: EdgeInsets.only(top: statusBarHeight),
              child: Align(
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0), // 원하는 곡률로 설정
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: width,
                      height: customHeight - viewInsets,
                      color: Colors.white, // 전체 오버레이의 배경색을 흰색으로 설정
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 40.0), // 제목과 상단의 간격을 아래로 내림
                                    Stack(
                                      children: [
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: '제목',
                                            hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0), // 제목 텍스트 크기 변경
                                            contentPadding: EdgeInsets.only(left: 10.0), // 오른쪽으로 이동
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 10, // 왼쪽으로 약간 이동
                                          top: 25, // 버튼의 위치를 약간 아래로 내림
                                          child: GestureDetector(
                                            onTap: () {
                                              // 나중에 색상 선택 오버레이 구현
                                            },
                                            child: Container(
                                              width: 17,
                                              height: 17,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey, // 기본 색상 설정
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5), // 제목과 시작 사이의 간격 조정
                                    Container(
                                      alignment: Alignment.centerLeft, // 왼쪽 정렬
                                      padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0), // 패딩 조정
                                      child: Text(
                                        '시작',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black), // 시작 텍스트 크기 변경
                                      ),
                                    ),
                                    SizedBox(height: 10), // 시작과 종료 사이의 간격을 줄임
                                    Container(
                                      padding: EdgeInsets.only(left: 10.0, right: 5.0, top: 10.0, bottom: 10.0), // 패딩 조정
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(color: Colors.grey), // 언더라인 추가
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '종료',
                                              style: TextStyle(fontSize: 16.0, color: Colors.black), // 종료 텍스트 크기 변경
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10), // 요소 간의 간격
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/category.svg', // SVG 파일 경로
                                          color: Colors.black, // 아이콘 색상을 검은색으로 설정
                                          width: 24,
                                          height: 24,
                                        ),
                                        SizedBox(width: 5), // 간격을 줄임
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: '카테고리',
                                              hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0), // 텍스트 크기 변경
                                              contentPadding: EdgeInsets.only(left: 10.0), // 오른쪽으로 이동
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10), // 요소 간의 간격
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/alarm.svg', // SVG 파일 경로
                                          color: Colors.black, // 아이콘 색상을 검은색으로 설정
                                          width: 24,
                                          height: 24,
                                        ),
                                        SizedBox(width: 5), // 간격을 줄임
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: '알림',
                                              hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0), // 텍스트 크기 변경
                                              contentPadding: EdgeInsets.only(left: 10.0), // 오른쪽으로 이동
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10), // 요소 간의 간격
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/repeat.svg', // SVG 파일 경로
                                          color: Colors.black, // 아이콘 색상을 검은색으로 설정
                                          width: 24,
                                          height: 24,
                                        ),
                                        SizedBox(width: 5), // 간격을 줄임
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: '반복',
                                              hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0), // 텍스트 크기 변경
                                              contentPadding: EdgeInsets.only(left: 10.0), // 오른쪽으로 이동
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10), // 요소 간의 간격
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/place.svg', // SVG 파일 경로
                                          color: Colors.black, // 아이콘 색상을 검은색으로 설정
                                          width: 24,
                                          height: 24,
                                        ),
                                        SizedBox(width: 5), // 간격을 줄임
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: '장소',
                                              hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0), // 텍스트 크기 변경
                                              contentPadding: EdgeInsets.only(left: 10.0), // 오른쪽으로 이동
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10), // 요소 간의 간격
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/memo.svg', // SVG 파일 경로
                                          color: Colors.black, // 아이콘 색상을 검은색으로 설정
                                          width: 24,
                                          height: 24,
                                        ),
                                        SizedBox(width: 5), // 간격을 줄임
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: '메모',
                                              hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0), // 텍스트 크기 변경
                                              contentPadding: EdgeInsets.only(left: 10.0), // 오른쪽으로 이동
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20), // 마지막 요소와 하단 버튼 사이의 간격
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.black, // 검은색 라인
                            height: 1.0, // 라인의 두께
                            margin: EdgeInsets.symmetric(horizontal: 15.0), // 스크롤 영역의 언더라인과 같은 길이로 설정
                          ),
                          Container(
                            height: 50.0, // 고정된 영역의 높이 설정
                            color: Colors.white, // 고정된 영역의 배경색 설정
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
                              children: [
                                Spacer(), // 좌측 여백을 위한 Spacer
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('취소'),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(100, 40), // 버튼 크기 조정
                                  ),
                                ),
                                SizedBox(width: 20), // 버튼 사이 여백
                                ElevatedButton(
                                  onPressed: () {
                                    // 이벤트 저장 로직 추가
                                    Navigator.pop(context);
                                  },
                                  child: Text('저장'),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(100, 40), // 버튼 크기 조정
                                  ),
                                ),
                                Spacer(), // 우측 여백을 위한 Spacer
                              ],
                            ),
                          ),
                        ],
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
