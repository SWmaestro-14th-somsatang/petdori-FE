import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/navigation_bar_widget.dart';
import 'package:wooyoungsoo/widgets/my_page_screen/go_to_another_page_widget.dart';
import 'package:wooyoungsoo/widgets/my_page_screen/membership_withdrawal_widget.dart';
import 'package:wooyoungsoo/widgets/my_page_screen/my_dogs_widget.dart';
import 'package:wooyoungsoo/widgets/my_page_screen/notification_setting_widget.dart';
import 'package:wooyoungsoo/widgets/my_page_screen/profile_widget.dart';
import 'package:wooyoungsoo/widgets/my_page_screen/version_info_widget.dart';

/// 마이페이지 화면
///
/// [screenWidth], [screenHeight] 화면의 너비와 높이
/// [currentIndex] 현재 화면의 인덱스
class MypageScreen extends StatelessWidget {
  const MypageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    const int currentIndex = 3;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        shadowColor: transparentColor,
        leadingWidth: 115,
        leading: Padding(
          padding: EdgeInsets.only(
            top: 15,
            left: screenWidth * 0.033,
          ),
          child: const Text(
            "마이페이지",
            style: TextStyle(
              fontSize: 18,
              fontWeight: fontWeightBold,
              color: blackColor,
            ),
          ),
        ),
      ),
      backgroundColor: whiteColor,
      bottomNavigationBar:
          const PetdoriNavigationBar(currentIndex: currentIndex),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Profile(screenHeight: screenHeight, screenWidth: screenWidth),
            MyDogs(screenHeight: screenHeight, screenWidth: screenWidth),
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.03),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.033,
              ),
              child: Column(
                children: [
                  GoToAnotherPage(
                    text: "이용약관",
                    onPressed: () {},
                  ),
                  const Gap(),
                  GoToAnotherPage(
                    text: "개인정보처리방침",
                    onPressed: () {},
                  ),
                  const Gap(),
                  const VersionInfo(),
                  const Gap(),
                  const NotificationSetting(),
                  const Gap(),
                  const Divider(
                    color: lightGreyColor,
                    thickness: 1,
                  ),
                  const Gap(),
                  GoToAnotherPage(
                    text: "친구 관리",
                    onPressed: () {},
                  ),
                  const Gap(),
                  const MembershipWithdrawal(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Gap extends StatelessWidget {
  const Gap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
    );
  }
}
