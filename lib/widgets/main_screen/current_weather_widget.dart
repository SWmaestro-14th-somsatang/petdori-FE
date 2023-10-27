import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 메인 화면 현재 날씨
///
/// [screenWidth] : 화면 너비
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
