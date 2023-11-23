import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 메인 화면 소개 문구
///
/// [screenWidth] : 화면 너비
class IntroductoryPhrase extends StatelessWidget {
  const IntroductoryPhrase({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.userName,
  });

  final double screenWidth, screenHeight;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.033,
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.025),
              Text(
                "$userName 님,",
                style: const TextStyle(
                  color: blackColor,
                  fontSize: 18,
                  fontWeight: fontWeightRegular,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "오늘도 산책을 남겨보세요 🐕",
                style: TextStyle(
                  color: blackColor,
                  fontSize: 22,
                  fontWeight: fontWeightBold,
                ),
              ),
              SizedBox(height: screenHeight * 0.025),
            ],
          ),
        ],
      ),
    );
  }
}
