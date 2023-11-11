import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/go_back_button_widget.dart';
import 'package:wooyoungsoo/widgets/common/navigation_bar_widget.dart';

class WalkLogDetailScreen extends StatelessWidget {
  const WalkLogDetailScreen({Key? key}) : super(key: key);
  final int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        shadowColor: transparentColor,
        leading: const GoBackButton(),
        title: const Text(
          "산책 상세 기록",
          style: TextStyle(
            color: blackColor,
            fontSize: 16,
            fontWeight: fontWeightMedium,
          ),
        ),
      ),
      backgroundColor: whiteColor,
      bottomNavigationBar: PetdoriNavigationBar(currentIndex: currentIndex),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.033,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "산책 날짜",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 18,
                      fontWeight: fontWeightBold,
                    ),
                  ),
                  Text(
                    "2023. 09. 22 19:12",
                    style: TextStyle(
                      color: darkGreyColor,
                      fontSize: 14,
                      fontWeight: fontWeightMedium,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth * 0.934,
              height: 200,
              margin: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.033,
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      children: [
                        Text(
                          "산책 시간",
                          style: TextStyle(
                            color: darkGreyColor,
                            fontSize: 14,
                            fontWeight: fontWeightMedium,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "00:00:00",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 18,
                            fontWeight: fontWeightBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 20,
                    color: mediumGreyColor,
                  ),
                  const Expanded(
                    child: Column(
                      children: [
                        Text(
                          "거리 (Km)",
                          style: TextStyle(
                            color: darkGreyColor,
                            fontSize: 14,
                            fontWeight: fontWeightMedium,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "1.2 Km",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 18,
                            fontWeight: fontWeightBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 20,
                    color: mediumGreyColor,
                  ),
                  const Expanded(
                    child: Column(
                      children: [
                        Text(
                          "평균 속력",
                          style: TextStyle(
                            color: darkGreyColor,
                            fontSize: 14,
                            fontWeight: fontWeightMedium,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "6’ 07’’",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 18,
                            fontWeight: fontWeightBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              width: screenWidth * 0.934,
              child: const Divider(
                color: lightGreyColor,
                thickness: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.033,
              ),
              child: const Row(
                children: [
                  Text(
                    "함께 산책한 강아지들",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 18,
                      fontWeight: fontWeightBold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: screenWidth * 0.934,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(
                          "./assets/images/default_dog_image.png",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "바둑이",
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 16,
                              fontWeight: fontWeightBold,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "약 130Kcal 소모",
                            style: TextStyle(
                              color: darkGreyColor,
                              fontSize: 14,
                              fontWeight: fontWeightMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
                itemCount: 2,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              width: screenWidth * 0.934,
              child: const Divider(
                color: lightGreyColor,
                thickness: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.033,
              ),
              child: const Row(
                children: [
                  Text(
                    "함께한 사진 📷",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 18,
                      fontWeight: fontWeightBold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth * 0.934,
              height: 200,
              margin: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
