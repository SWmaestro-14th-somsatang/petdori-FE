import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/provider_icon_widget.dart';

class Profile extends StatelessWidget {
  const Profile({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.015),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.033,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage("assets/images/karina.jpeg"),
          ),
          SizedBox(
            width: screenWidth * 0.033,
          ),
          const SizedBox(
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "카리나 님",
                  style: TextStyle(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: fontWeightBold,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    ProviderIcon(provider: "kakao"),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "adasd@naver.com",
                      style: TextStyle(
                        fontSize: 14,
                        color: mediumGreyColor,
                        fontWeight: fontWeightRegular,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shadowColor: Colors.transparent,
              ),
              onPressed: () {},
              child: const Text(
                "로그아웃",
                style: TextStyle(
                  fontSize: 14,
                  color: mediumGreyColor,
                  fontWeight: fontWeightRegular,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
