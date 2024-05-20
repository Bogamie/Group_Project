import 'package:flutter/material.dart';
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
              Positioned(
                child: Text(
                  "${DateTime.now().day}",
                  style: const TextStyle(
                    letterSpacing: -1,
                  ),
                ),
              ),
              IconButton(
                onPressed: onMoveTo,
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
    );
  }
}
