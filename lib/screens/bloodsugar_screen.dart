import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    const int currentIndex = 1;

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
      bottomNavigationBar:
          const PetdoriNavigationBar(currentIndex: currentIndex),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 20.0,
                  ),
                  child: Text(
                    '실시간 혈당 그래프',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 50.0, top: 10.0),
                //   child: CalendarWidget(),
                // ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white, // 배경색
                borderRadius: BorderRadius.circular(30.0), // 모서리 둥글게 설정
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: LineChartWidget(screenWidth: screenWidth),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                left: 20.0,
                bottom: 5.0,
              ),
              child: Text(
                '주요 수치',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          decoration: ShapeDecoration(
                            color: Colors.blue,
                            shape: OvalBorder(),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 22,
                        left: 10,
                        child: Text(
                          'Number of Spikes',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '2',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'times',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)
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
                          decoration: ShapeDecoration(
                            color: Colors.blueGrey,
                            shape: OvalBorder(),
                          ),
                        ),
                      ),

                      Positioned(
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
                      Positioned(
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
                      Positioned(
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
                            Text(
                              'mg/dL',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 20.0,
                bottom: 5.0,
              ),
              child: Text(
                '혈당 분포도',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white, // 배경색
                borderRadius: BorderRadius.circular(30.0), // 모서리 둥글게 설정
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
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


