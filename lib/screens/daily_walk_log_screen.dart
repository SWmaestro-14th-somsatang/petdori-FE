import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wooyoungsoo/models/monthly_walk_log_model.dart';
import 'package:wooyoungsoo/services/walk_log_service/walk_log_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/go_back_button_widget.dart';
import 'package:wooyoungsoo/widgets/common/navigation_bar_widget.dart';
import 'package:wooyoungsoo/widgets/walk_log_screen/monthly_walking_log_view_widget.dart';

/// 일별 산책 기록 목록 조회 화면
///
/// [walkedDate] 조회할 산책 기록의 날짜
class DailyWalkLogScreen extends StatefulWidget {
  const DailyWalkLogScreen({Key? key, required this.walkedDate})
      : super(key: key);
  final DateTime walkedDate;

  @override
  State<DailyWalkLogScreen> createState() => _WalkLogDetailScreenState();
}

/// 일별 산책 기록 목록 조회 화면의 상태
///
/// [walkLogService] 산책 기록 서비스
/// [dailyWalkLogs] 일별 산책 기록 리스트
/// [currentIndex] 현재 화면의 인덱스
/// [isLoading] 산책 기록을 불러오는 중인지 여부
class _WalkLogDetailScreenState extends State<DailyWalkLogScreen> {
  final WalkLogService walkLogService = WalkLogService();
  List<MonthlyWalkLogModel> dailyWalkLogs = [];
  final int currentIndex = 1;
  bool isLoading = true;

  void loadDailyWalkLogs() async {
    dailyWalkLogs = await walkLogService.getDailyWalkLogs(
      year: widget.walkedDate.year,
      month: widget.walkedDate.month,
      day: widget.walkedDate.day,
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadDailyWalkLogs();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        shadowColor: transparentColor,
        leading: const GoBackButton(),
        title: Text(
          "${widget.walkedDate.year}년 ${widget.walkedDate.month}월 ${widget.walkedDate.day}일",
          style: const TextStyle(
            color: blackColor,
            fontSize: 16,
            fontWeight: fontWeightMedium,
          ),
        ),
      ),
      backgroundColor: whiteColor,
      bottomNavigationBar: PetdoriNavigationBar(currentIndex: currentIndex),
      body: isLoading
          ? const SizedBox(
              height: double.infinity,
              child: SpinKitCircle(
                color: mainColor,
                size: 50,
              ),
            )
          : dailyWalkLogs.isEmpty
              ? Container(
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: screenHeight * 0.175,
                    ),
                    child: const Text(
                      "산책 기록이 없습니다.",
                      style: TextStyle(
                        color: darkGreyColor,
                        fontSize: 14,
                        fontWeight: fontWeightRegular,
                      ),
                    ),
                  ))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      MonthlyWalkingLogView(
                        screenWidth: screenWidth,
                        monthlyWalkLogs: dailyWalkLogs,
                      ),
                    ],
                  ),
                ),
    );
  }
}
