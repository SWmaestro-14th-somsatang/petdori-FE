import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wooyoungsoo/models/monthly_walk_log_model.dart';
import 'package:wooyoungsoo/services/walk_log_service/walk_log_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/go_back_button_widget.dart';
import 'package:wooyoungsoo/widgets/common/navigation_bar_widget.dart';
import 'package:wooyoungsoo/widgets/walk_log_screen/monthly_walking_log_view_widget.dart';

/// 월별 산책 로그 화면
///
/// [screenWidth], [screenHeight] 화면의 너비와 높이
/// [currentIndex] 현재 화면의 인덱스
class MonthlyWalkLogScreen extends StatefulWidget {
  const MonthlyWalkLogScreen({Key? key}) : super(key: key);

  @override
  State<MonthlyWalkLogScreen> createState() => _MonthlyLogScreenState();
}

/// 월별 산책 로그 화면의 상태
///
/// [walkLogService] 산책 로그 서비스
/// [recentlyWalkLogs] 최근 30일 산책 로그 리스트
/// [monthlyWalkLogs] 이번 달 산책 로그 리스트
class _MonthlyLogScreenState extends State<MonthlyWalkLogScreen> {
  final WalkLogService walkLogService = WalkLogService();
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  List<MonthlyWalkLogModel> monthlyWalkLogs = [];
  bool isLoading = true;

  void loadWalkLogs({required year, required month}) async {
    monthlyWalkLogs = await walkLogService.getMonthlyWalkLogs(
      year: year,
      month: month,
    );

    setState(() {
      isLoading = false;
    });
  }

  void loadPreviousMonthLogs() {
    if (month == 1) {
      year -= 1;
      month = 12;
    } else {
      month -= 1;
    }

    setState(() {
      isLoading = true;
    });

    loadWalkLogs(year: year, month: month);
  }

  void loadNextMonthLogs() {
    if (month == DateTime.now().month && year == DateTime.now().year) {
      return;
    }

    if (month == 12) {
      year += 1;
      month = 1;
    } else {
      month += 1;
    }

    setState(() {
      isLoading = true;
    });

    loadWalkLogs(year: year, month: month);
  }

  @override
  void initState() {
    super.initState();
    loadWalkLogs(year: year, month: month);
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
        leading: const GoBackButton(),
        title: const Text(
          "월별 산책 기록",
          style: TextStyle(
            color: blackColor,
            fontSize: 16,
            fontWeight: fontWeightMedium,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: loadPreviousMonthLogs,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: darkGreyColor,
                    size: 18,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Baseline(
                  baselineType: TextBaseline.alphabetic,
                  baseline: 15,
                  child: Text(
                    "$year년 $month월",
                    style: const TextStyle(
                      color: blackColor,
                      fontSize: 16,
                      fontWeight: fontWeightMedium,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  onPressed: loadNextMonthLogs,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: darkGreyColor,
                    size: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            isLoading
                ? SizedBox(
                    height: screenHeight * 0.6,
                    child: const SpinKitCircle(
                      color: mainColor,
                      size: 50,
                    ),
                  )
                : monthlyWalkLogs.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                        ),
                        child: Text(
                          "이 달의 산책 기록이 없습니다.",
                          style: TextStyle(
                            color: darkGreyColor,
                            fontSize: 16,
                            fontWeight: fontWeightRegular,
                          ),
                        ),
                      )
                    : MonthlyWalkingLogView(
                        screenWidth: screenWidth,
                        monthlyWalkLogs: monthlyWalkLogs,
                      ),
          ],
        ),
      ),
    );
  }
}
