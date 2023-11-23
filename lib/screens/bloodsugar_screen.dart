import 'package:flutter/material.dart';
import 'package:wooyoungsoo/widgets/chart_screen/linechart_widget.dart';
import 'package:wooyoungsoo/widgets/chart_screen/piechart_widget.dart';

import '../utils/constants.dart';
import '../widgets/common/navigation_bar_widget.dart';

class BloodSugarScreen extends StatefulWidget {
  const BloodSugarScreen({Key? key}) : super(key: key);

  @override
  _BloodSugarScreenState createState() => _BloodSugarScreenState();
}

class _BloodSugarScreenState extends State<BloodSugarScreen> {
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
            "혈당 분석",
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
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.033,
                  ),
                  child: const Text(
                    '실시간 혈당 그래프',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: fontWeightBold,
                      color: blackColor,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: screenWidth * 0.934,
              margin: EdgeInsets.only(
                top: screenHeight * 0.02,
                bottom: screenHeight * 0.04,
              ),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: lightGreyColor,
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: LineChartWidget(screenWidth: screenWidth),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.033,
                  ),
                  child: const Text(
                    '주요 수치',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: fontWeightBold,
                      color: blackColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            SizedBox(
              width: screenWidth * 0.934,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 165,
                    height: 165,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -70,
                          left: -40,
                          child: Container(
                            width: 131,
                            height: 133,
                            decoration: const ShapeDecoration(
                              color: mainColor,
                              shape: OvalBorder(),
                            ),
                          ),
                        ),
                        const Positioned(
                          top: 22,
                          left: 10,
                          child: Text(
                            'Number of Spikes',
                            style: TextStyle(
                              fontSize: 16,
                              color: blackColor,
                              fontWeight: fontWeightBold,
                            ),
                          ),
                        ),
                        const Positioned(
                          bottom: 30,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '2',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: blackColor,
                                  fontWeight: fontWeightBold,
                                ),
                              ),
                              Text(
                                'times',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: blackColor,
                                  fontWeight: fontWeightBold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 165,
                    height: 165,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -70,
                          left: -40,
                          child: Container(
                            width: 131,
                            height: 133,
                            decoration: const ShapeDecoration(
                              color: Colors.blueGrey,
                              shape: OvalBorder(),
                            ),
                          ),
                        ),
                        const Positioned(
                          top: 5,
                          left: 15,
                          child: Text(
                            'Avg.',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Positioned(
                          top: 22,
                          left: 28,
                          child: Text(
                            'Blood Sugar',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Positioned(
                          bottom: 30,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '76',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('mg/dL',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.033,
                  ),
                  child: const Text(
                    '혈당 분포도',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: fontWeightBold,
                      color: blackColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Container(
              width: screenWidth * 0.934,
              decoration: BoxDecoration(
                color: whiteColor, // 배경색
                borderRadius: BorderRadius.circular(10), // 모서리 둥글게 설정
                boxShadow: const [
                  BoxShadow(
                    color: lightGreyColor,
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: PieChartWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
