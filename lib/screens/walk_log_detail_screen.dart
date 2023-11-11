import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wooyoungsoo/models/walk_log_detail_model.dart';
import 'package:wooyoungsoo/services/walk_log_service/walk_log_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/go_back_button_widget.dart';
import 'package:wooyoungsoo/widgets/common/navigation_bar_widget.dart';

class WalkLogDetailScreen extends StatefulWidget {
  const WalkLogDetailScreen({Key? key, required this.walkLogId})
      : super(key: key);
  final int walkLogId;

  @override
  State<WalkLogDetailScreen> createState() => _WalkLogDetailScreenState();
}

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

  String getAverageSpeed({
    required Duration walkingTime,
    required double walkedDistance,
  }) {
    int walkingTimeInMinutes = walkingTime.inMinutes;

    // 1km를 가는데 걸리는 시간을 분으로 계산
    double timePerKmInMinutes = walkingTimeInMinutes / walkedDistance;

    // 계산된 시간을 분과 초로 분리
    int minutes = timePerKmInMinutes.toInt();
    int seconds = ((timePerKmInMinutes - minutes) * 60).toInt();

    return seconds < 10 ? "$minutes’ 0$seconds’’" : "$minutes’ $seconds’’";
  }

  @override
  void initState() {
    super.initState();
    loadWalkLogDetail();
  }

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
      body: isLoading
          ? const SizedBox(
              height: double.infinity,
              child: SpinKitCircle(
                color: mainColor,
                size: 50,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.033,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "산책 날짜",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 18,
                            fontWeight: fontWeightBold,
                          ),
                        ),
                        Text(
                          "${walkLogDetail!.startedTime.toString().split(":")[0]}:${walkLogDetail!.startedTime.toString().split(":")[1]}",
                          style: const TextStyle(
                            color: darkGreyColor,
                            fontSize: 14,
                            fontWeight: fontWeightRegular,
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
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                "산책 시간",
                                style: TextStyle(
                                  color: darkGreyColor,
                                  fontSize: 14,
                                  fontWeight: fontWeightRegular,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                walkLogDetail!.walkingTime
                                            .toString()
                                            .split(":")[0]
                                            .length ==
                                        1
                                    ? "0${walkLogDetail!.walkingTime.toString().split(".")[0]}"
                                    : walkLogDetail!.walkingTime
                                        .toString()
                                        .split(".")[0],
                                style: const TextStyle(
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
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                "거리 (Km)",
                                style: TextStyle(
                                  color: darkGreyColor,
                                  fontSize: 14,
                                  fontWeight: fontWeightRegular,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                "${walkLogDetail!.walkedDistance} Km",
                                style: const TextStyle(
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
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                "평균 속력",
                                style: TextStyle(
                                  color: darkGreyColor,
                                  fontSize: 14,
                                  fontWeight: fontWeightRegular,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                getAverageSpeed(
                                  walkingTime: walkLogDetail!.walkingTime,
                                  walkedDistance: walkLogDetail!.walkedDistance,
                                ),
                                style: const TextStyle(
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
                        return Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: walkLogDetail!
                                          .walkedDogs[index].dogImageUrl ==
                                      null
                                  ? const AssetImage(
                                      "./assets/images/default_dog_image.png",
                                    )
                                  : NetworkImage(
                                      walkLogDetail!
                                          .walkedDogs[index].dogImageUrl!,
                                    ) as ImageProvider,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  walkLogDetail!.walkedDogs[index].dogName,
                                  style: const TextStyle(
                                    color: blackColor,
                                    fontSize: 16,
                                    fontWeight: fontWeightBold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "약 ${walkLogDetail!.walkedDogs[index].burnedCalorie}kcal 소모",
                                  style: const TextStyle(
                                    color: darkGreyColor,
                                    fontSize: 14,
                                    fontWeight: fontWeightRegular,
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
                      itemCount: walkLogDetail!.walkedDogs.length,
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
                    height: walkLogDetail!.walkingImageUrl == null ? 200 : 250,
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: lightGreyColor,
                      borderRadius: BorderRadius.circular(10),
                      image: walkLogDetail!.walkingImageUrl == null
                          ? null
                          : DecorationImage(
                              image: NetworkImage(
                                walkLogDetail!.walkingImageUrl!,
                              ),
                              fit: BoxFit.cover,
                            ),
                    ),
                    alignment: Alignment.center,
                    child: walkLogDetail!.walkingImageUrl == null
                        ? const Text(
                            "저장된 산책 사진이 없습니다",
                            style: TextStyle(
                              color: darkGreyColor,
                              fontSize: 14,
                              fontWeight: fontWeightRegular,
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
    );
  }
}
