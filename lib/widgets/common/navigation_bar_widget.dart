import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 펫돌이 하단 네비게이션 바
///
/// [currentIndex] : 현재 선택된 인덱스
class PetdoriNavigationBar extends StatelessWidget {
  const PetdoriNavigationBar({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      padding: const EdgeInsets.only(top: 5),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor: whiteColor,
        selectedItemColor: mainColor,
        unselectedItemColor: navGreyColor,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, "/");
              break;
            case 1:
              Navigator.pushNamed(context, "/log");
              break;
            case 2:
              Navigator.pushNamed(context, "/nearby");
              break;
            case 3:
              Navigator.pushNamed(context, "/blood-sugar");
              break;
            case 4:
              Navigator.pushNamed(context, "/mypage");
              break;
            default:
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notes_rounded,
            ),
            label: "기록",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on_rounded,
            ),
            label: "내 주변",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.auto_graph_rounded,
            ),
            label: "혈당 분석",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "마이페이지",
          ),
        ],
      ),
    );
  }
}
