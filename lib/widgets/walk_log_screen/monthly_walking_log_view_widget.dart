import 'package:flutter/material.dart';
import 'package:wooyoungsoo/models/monthly_walk_log_model.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 월별 산책 기록 리스트 위젯
///
/// [screenWidth] 화면의 너비
/// [monthlyWalkLogs] 월별 산책 기록 목록
class MonthlyWalkingLogView extends StatelessWidget {
  const MonthlyWalkingLogView({
    super.key,
    required this.screenWidth,
    required this.monthlyWalkLogs,
  });

  final double screenWidth;
  final List<MonthlyWalkLogModel> monthlyWalkLogs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.033,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/log-detail",
              );
            },
            child: Container(
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
                                image: NetworkImage(
                                    monthlyWalkLogs[index].walkingImageUrl!),
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
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Gap();
        },
        itemCount: monthlyWalkLogs.length,
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
