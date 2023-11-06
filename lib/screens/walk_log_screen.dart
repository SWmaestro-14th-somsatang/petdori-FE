import 'package:flutter/material.dart';
import 'package:wooyoungsoo/models/monthly_walk_log_model.dart';
import 'package:wooyoungsoo/services/walk_log_service/walk_log_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/navigation_bar_widget.dart';

/// 마이페이지 화면
///
/// [screenWidth], [screenHeight] 화면의 너비와 높이
/// [currentIndex] 현재 화면의 인덱스
class WalkLogScreen extends StatefulWidget {
  const WalkLogScreen({Key? key}) : super(key: key);

  @override
  State<WalkLogScreen> createState() => _WalkLogScreenState();
}

class _WalkLogScreenState extends State<WalkLogScreen> {
  final WalkLogService walkLogService = WalkLogService();
  List<MonthlyWalkLogModel> monthlyWalkLogs = [];

  void loadMonthlyWalkLogs() async {
    monthlyWalkLogs = await walkLogService.getMonthlyWalkLogs(
      year: DateTime.now().year,
      month: DateTime.now().month,
    );

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadMonthlyWalkLogs();
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
              child: Column(
                children: [
                  SizedBox(
                    width: 270,
                    height: 30,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      itemCount: 7,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 270,
                    height: 30,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      itemCount: 7,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 270,
                    height: 30,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      itemCount: 7,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 270,
                    height: 30,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      itemCount: 7,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 270,
                    height: 30,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      itemCount: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "0km",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: fontWeightMedium,
                          color: darkGreyColor,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: blueColorLv1,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: blueColorLv2,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: blueColorLv3,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: blueColorLv4,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: blueColorLv5,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Text(
                        "5km",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: fontWeightMedium,
                          color: darkGreyColor,
                        ),
                      ),
                    ],
                  ),
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
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.033,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: boxGreyColor,
                          blurRadius: 50,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          monthlyWalkLogs[index].walkingImageUrl == null
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/default_dog_image.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(monthlyWalkLogs[index]
                                          .walkingImageUrl!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  monthlyWalkLogs[index]
                                      .startedTime
                                      .toString()
                                      .split(" ")[0],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: fontWeightBold,
                                    color: mainColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Divider(
                                  color: lightGreyColor,
                                  thickness: 1,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Row(
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: Text(
                                        "산책 시간",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: fontWeightMedium,
                                          color: darkGreyColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "거리 (km)",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: fontWeightMedium,
                                        color: darkGreyColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: Text(
                                        monthlyWalkLogs[index]
                                                    .walkingTime
                                                    .toString()
                                                    .split(".")[0][0] ==
                                                "0"
                                            ? "0${monthlyWalkLogs[index].walkingTime.toString().split(".")[0]}"
                                            : monthlyWalkLogs[index]
                                                .walkingTime
                                                .toString()
                                                .split(".")[0],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: fontWeightMedium,
                                          color: blackColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${monthlyWalkLogs[index].walkedDistance}km",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: fontWeightMedium,
                                        color: blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Gap();
                },
                itemCount: monthlyWalkLogs.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Gap extends StatelessWidget {
  const Gap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10,
    );
  }
}
