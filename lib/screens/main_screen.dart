import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/navigation_bar_widget.dart';
import 'package:wooyoungsoo/widgets/main_screen/current_weather_widget.dart';
import 'package:wooyoungsoo/widgets/main_screen/introduce_phrase_widget.dart';
import 'package:wooyoungsoo/widgets/main_screen/user_walking_goal_widget.dart';

/// 메인 화면
///
/// [screenWidth], [screenHeight] 화면의 너비와 높이
/// [currentIndex] 현재 화면의 인덱스
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    const int currentIndex = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainScreenBackgroundColor,
        shadowColor: transparentColor,
        leadingWidth: 115,
        leading: Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.033,
          ),
          child: SvgPicture.asset(
            appLogoPath,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_rounded,
              color: darkGreyColor,
            ),
            iconSize: 24,
          ),
        ],
      ),
      backgroundColor: mainScreenBackgroundColor,
      bottomNavigationBar:
          const PetdoriNavigationBar(currentIndex: currentIndex),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IntroductoryPhrase(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            CurrentWeather(screenWidth: screenWidth),
            UserWalkingGoal(screenWidth: screenWidth)
          ],
        ),
      ),
    );
  }
}
