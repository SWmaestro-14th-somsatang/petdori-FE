import 'package:flutter/material.dart';

/// 홈 화면 소개 문구
///
/// [screenWidth] : 화면 너비
class IntroductoryPhrase extends StatelessWidget {
  const IntroductoryPhrase({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.033,
      ),
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "우리집 멍·냥이",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "영양 ",
                        style: TextStyle(
                          color: Color(0xFF8889f3),
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          fontFamily: "NotoSansKR",
                        ),
                      ),
                      TextSpan(
                        text: "절대 지켜!!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          fontFamily: "NotoSansKR",
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
