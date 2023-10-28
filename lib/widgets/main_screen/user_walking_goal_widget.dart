import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 메인 화면 산책 목표 위젯
///
/// [screenWidth] : 화면 너비
class UserWalkingGoal extends StatelessWidget {
  const UserWalkingGoal({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
