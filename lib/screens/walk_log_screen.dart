import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wooyoungsoo/models/monthly_walk_log_model.dart';
import 'package:wooyoungsoo/models/recently_walk_log_model.dart';
import 'package:wooyoungsoo/services/walk_log_service/walk_log_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/navigation_bar_widget.dart';
import 'package:wooyoungsoo/widgets/walk_log_screen/monthly_walking_log_view_widget.dart';
import 'package:wooyoungsoo/widgets/walk_log_screen/walking_farm_color_bar_widget.dart';
import 'package:wooyoungsoo/widgets/walk_log_screen/walking_farm_row_widget.dart';

/// 산책 로그 화면
///
/// [screenWidth], [screenHeight] 화면의 너비와 높이
/// [currentIndex] 현재 화면의 인덱스
class WalkLogScreen extends StatefulWidget {
  const WalkLogScreen({Key? key}) : super(key: key);

  @override
  State<WalkLogScreen> createState() => _WalkLogScreenState();
}

/// 산책 로그 화면의 상태
///
/// [walkLogService] 산책 로그 서비스
/// [recentlyWalkLogs] 최근 30일 산책 로그 리스트
/// [monthlyWalkLogs] 이번 달 산책 로그 리스트
class _WalkLogScreenState extends State<WalkLogScreen> {
  final WalkLogService walkLogService = WalkLogService();
  List<RecentlyWalkLogModel> recentlyWalkLogs = [];
  List<MonthlyWalkLogModel> monthlyWalkLogs = [];

  void loadWalkLogs() async {
    recentlyWalkLogs = await walkLogService.getRecentlyWalkLogs();

    monthlyWalkLogs = await walkLogService.getMonthlyWalkLogs(
      year: DateTime.now().year,
      month: DateTime.now().month,
    );

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadWalkLogs();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    const int currentIndex = 1;

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
            "산책 기록",
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
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.033,
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "산책 밭",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: fontWeightBold,
                      color: blackColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "최근 30일",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: fontWeightMedium,
                      color: mainColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth * 0.934,
              margin: EdgeInsets.only(
                top: screenHeight * 0.02,
                bottom: screenHeight * 0.04,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: lightGreyColor,
                  width: 1,
                ),
              ),
              child: recentlyWalkLogs.isEmpty
                  ? const SizedBox(
                      height: 220,
                      child: SpinKitCircle(
                        color: mainColor,
                        size: 50,
                      ),
                    )
                  : Column(
                      children: [
                        WalkingFarmRow(
                          walkLogs: recentlyWalkLogs.sublist(0, 7),
                        ),
                        const SizedBox(height: 8),
                        WalkingFarmRow(
                          walkLogs: recentlyWalkLogs.sublist(7, 14),
                        ),
                        const SizedBox(height: 8),
                        WalkingFarmRow(
                          walkLogs: recentlyWalkLogs.sublist(14, 21),
                        ),
                        const SizedBox(height: 8),
                        WalkingFarmRow(
                          walkLogs: recentlyWalkLogs.sublist(21, 28),
                        ),
                        const SizedBox(height: 8),
                        WalkingFarmRow(
                          walkLogs: recentlyWalkLogs.sublist(28, 30),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const WalkingFarmColorBar(),
                      ],
                    ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.033,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "이번 달 산책 기록",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: fontWeightBold,
                      color: blackColor,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Baseline(
                          baselineType: TextBaseline.alphabetic,
                          baseline: 15,
                          child: Text(
                            "다른 달 기록 보기",
                            style: TextStyle(
                              color: darkGreyColor,
                              fontSize: 14,
                              fontWeight: fontWeightMedium,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: darkGreyColor,
                          size: 12,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MonthlyWalkingLogView(
              screenWidth: screenWidth,
              monthlyWalkLogs: monthlyWalkLogs,
            ),
          ],
        ),
      ),
    );
  }
}
