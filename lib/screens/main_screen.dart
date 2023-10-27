import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/main_screen/introduce_phrase_widget.dart';

/// 홈 화면
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            IntroductoryPhrase(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            CurrentWeather(screenWidth: screenWidth),
            Container(
              width: screenWidth * 0.934,
              margin: const EdgeInsets.only(
                top: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Text(
                        "이번 주 산책 목표 현황",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 18,
                          fontWeight: fontWeightBold,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "목표 수정하기",
                              style: TextStyle(
                                color: mediumGreyColor,
                                fontSize: 16,
                                fontWeight: fontWeightRegular,
                              ),
                            ),
                            SizedBox(width: 4),
                            Baseline(
                              baselineType: TextBaseline.alphabetic,
                              baseline: 15,
                              child: Icon(
                                Icons.arrow_forward_ios_sharp,
                                color: mediumGreyColor,
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 1,
                        color: lightBlueColor,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "총 3번 중",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 16,
                            fontWeight: fontWeightRegular,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "2번",
                                style: TextStyle(
                                  color: mainColor,
                                  fontSize: 20,
                                  fontWeight: fontWeightBold,
                                  fontFamily: "NotoSansKR",
                                ),
                              ),
                              TextSpan(
                                text: "을 산책했어요",
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 16,
                                  fontWeight: fontWeightRegular,
                                  fontFamily: "NotoSansKR",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 1,
                        color: lightBlueColor,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "총 10km 중",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 16,
                            fontWeight: fontWeightRegular,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "6.2km",
                                style: TextStyle(
                                  color: mainColor,
                                  fontSize: 20,
                                  fontWeight: fontWeightBold,
                                  fontFamily: "NotoSansKR",
                                ),
                              ),
                              TextSpan(
                                text: "를 산책했어요",
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 16,
                                  fontWeight: fontWeightRegular,
                                  fontFamily: "NotoSansKR",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.934,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: lightGreyColor,
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 25),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "지금 ",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 18,
                        fontWeight: fontWeightRegular,
                        fontFamily: "NotoSansKR",
                      ),
                    ),
                    TextSpan(
                      text: "서울시 강남구",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 18,
                        fontWeight: fontWeightBold,
                        fontFamily: "NotoSansKR",
                      ),
                    ),
                    TextSpan(
                      text: "는...",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 18,
                        fontWeight: fontWeightRegular,
                        fontFamily: "NotoSansKR",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    "⛅️",
                    style: TextStyle(
                      fontSize: 34,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "조금은 흐린 날씨",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 18,
                      fontWeight: fontWeightMedium,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth * 0.868, 50),
                  backgroundColor: mainColor,
                  foregroundColor: whiteColor,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                ),
                child: const Text(
                  "산책 시작하기",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: fontWeightBold,
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ],
      ),
    );
  }
}
