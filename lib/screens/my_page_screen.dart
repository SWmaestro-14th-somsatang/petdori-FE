import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/navigation_bar_widget.dart';
import 'package:wooyoungsoo/widgets/common/provider_icon_widget.dart';

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
                  Row(
                    children: [
                      const Baseline(
                        baselineType: TextBaseline.alphabetic,
                        baseline: 14,
                        child: Text(
                          "이용약관",
                          style: TextStyle(
                            fontSize: 16,
                            color: blackColor,
                            fontWeight: fontWeightMedium,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: darkGreyColor,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Baseline(
                        baselineType: TextBaseline.alphabetic,
                        baseline: 14,
                        child: Text(
                          "개인정보처리방침",
                          style: TextStyle(
                            fontSize: 16,
                            color: blackColor,
                            fontWeight: fontWeightMedium,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: darkGreyColor,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    children: [
                      Text(
                        "버전 정보",
                        style: TextStyle(
                          fontSize: 16,
                          color: blackColor,
                          fontWeight: fontWeightMedium,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "v1.0.0",
                        style: TextStyle(
                          fontSize: 16,
                          color: mainColor,
                          fontWeight: fontWeightRegular,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Baseline(
                        baselineType: TextBaseline.alphabetic,
                        baseline: 14,
                        child: Text(
                          "알림 설정",
                          style: TextStyle(
                            fontSize: 16,
                            color: blackColor,
                            fontWeight: fontWeightMedium,
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 40,
                        height: 30,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: CupertinoSwitch(
                            value: true,
                            onChanged: (value) {},
                            activeColor: mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(
                    color: lightGreyColor,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Baseline(
                        baselineType: TextBaseline.alphabetic,
                        baseline: 14,
                        child: Text(
                          "친구 관리",
                          style: TextStyle(
                            fontSize: 16,
                            color: blackColor,
                            fontWeight: fontWeightMedium,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: darkGreyColor,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          "회원탈퇴",
                          style: TextStyle(
                            color: darkGreyColor,
                            fontSize: 14,
                            fontWeight: fontWeightMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyDogs extends StatelessWidget {
  const MyDogs({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: screenHeight * 0.035,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.033,
            ),
            child: Row(
              children: [
                const Text(
                  "내 반려견들",
                  style: TextStyle(
                    fontSize: 16,
                    color: blackColor,
                    fontWeight: fontWeightBold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "+ 반려견 추가하기",
                    style: TextStyle(
                      fontSize: 16,
                      color: mainColor,
                      fontWeight: fontWeightMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: screenWidth * 0.033,
                  ),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: lightGreyColor,
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                AssetImage("assets/images/dog_profile.jpeg"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "바둑이",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: blackColor,
                                    fontWeight: fontWeightBold,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "리트리버",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: mainColor,
                                    fontWeight: fontWeightMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 0,
                );
              },
              itemCount: 4,
            ),
          )
        ],
      ),
    );
  }
}

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
