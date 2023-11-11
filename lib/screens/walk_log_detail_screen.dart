import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wooyoungsoo/models/walk_log_detail_model.dart';
import 'package:wooyoungsoo/services/walk_log_service/walk_log_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/go_back_button_widget.dart';
import 'package:wooyoungsoo/widgets/common/navigation_bar_widget.dart';
import 'package:wooyoungsoo/widgets/walk_log_detail_screen/walk_summary_widget.dart';
import 'package:wooyoungsoo/widgets/walk_log_detail_screen/walked_dogs_widget.dart';
import 'package:wooyoungsoo/widgets/walk_log_detail_screen/walking_image_widget.dart';

/// 산책 기록 상세 화면
///
/// [walkLogId] 산책 기록 아이디
class WalkLogDetailScreen extends StatefulWidget {
  const WalkLogDetailScreen({Key? key, required this.walkLogId})
      : super(key: key);
  final int walkLogId;

  @override
  State<WalkLogDetailScreen> createState() => _WalkLogDetailScreenState();
}

/// 산책 기록 상세 화면의 상태
///
/// [walkLogService] 산책 기록 서비스
/// [walkLogDetail] 산책 기록 상세 정보
/// [currentIndex] 현재 화면의 인덱스
/// [isLoading] 산책 기록 상세 정보를 불러오는 중인지 여부
class _WalkLogDetailScreenState extends State<WalkLogDetailScreen> {
  final WalkLogService walkLogService = WalkLogService();
  WalkLogDetailModel? walkLogDetail;
  final int currentIndex = 1;
  bool isLoading = true;

  Future loadWalkLogDetail() async {
    walkLogDetail = await walkLogService.getWalkLogDetail(
      walkLogId: widget.walkLogId,
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadWalkLogDetail();
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
      body: isLoading
          ? const SizedBox(
              height: double.infinity,
              child: SpinKitCircle(
                color: mainColor,
                size: 50,
              ),
            )
          : walkLogDetail == null
              ? Container(
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: screenHeight * 0.175,
                    ),
                    child: const Text(
                      "산책 기록을 불러오지 못했습니다.",
                      style: TextStyle(
                        color: darkGreyColor,
                        fontSize: 16,
                        fontWeight: fontWeightRegular,
                      ),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      WalkSummary(
                        screenWidth: screenWidth,
                        startedTime: walkLogDetail!.startedTime,
                        walkingRouteFileUrl: walkLogDetail!.walkingRouteFileUrl,
                        walkingTime: walkLogDetail!.walkingTime,
                        walkedDistance: walkLogDetail!.walkedDistance,
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
                      WalkedDogs(
                        screenWidth: screenWidth,
                        walkedDogs: walkLogDetail!.walkedDogs,
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
                      WalkingImage(
                        screenWidth: screenWidth,
                        walkingImageUrl: walkLogDetail!.walkingImageUrl,
                      ),
                    ],
                  ),
                ),
    );
  }
}
