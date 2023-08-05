import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/home_screen/additional_feature_buttons_widget.dart';
import 'package:wooyoungsoo/widgets/home_screen/feature_search_bar_widget.dart';
import 'package:wooyoungsoo/widgets/home_screen/home_header_widget.dart';
import 'package:wooyoungsoo/widgets/home_screen/introduce_phrase_widget.dart';
import 'package:wooyoungsoo/widgets/home_screen/main_feature_buttons_widget.dart';

/// 홈 화면
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: screenBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.033,
        ),
        child: Column(
          children: [
            HomeHeader(screenWidth: screenWidth),
            IntroductoryPhrase(screenWidth: screenWidth),
            const FeatureSearchBar(),
            const MainFeatureButtons(),
            AdditionalFeatureButtons(),
          ],
        ),
      ),
    );
  }
}
