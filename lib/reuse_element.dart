import 'package:flutter/material.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter_svg/flutter_svg.dart';

// AppBar 상단 버튼
class TopMenu extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMoveTo;

  const TopMenu({super.key, required this.onMoveTo});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: GestureDetector(
        onTap: () {
          // 메뉴바 확장
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: SvgPicture.asset(
                "assets/icons/menu.svg",
              ),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            // 검색 기능
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: SvgPicture.asset(
                  "assets/icons/search.svg",
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: onMoveTo,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 7,
                    cornerSmoothing: 0.6,
                  ),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  "${DateTime.now().day}",
                  style: const TextStyle(
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }
}