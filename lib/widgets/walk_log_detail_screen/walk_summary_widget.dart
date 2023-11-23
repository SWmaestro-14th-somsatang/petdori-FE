import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 산책 로그의 요약 정보를 보여주는 위젯
///
/// [screenWidth] 화면의 너비
/// [startedTime] 산책 시작 시간
/// [walkingRouteFileUrl] 산책 경로 파일의 URL
/// [walkingTime] 산책에 걸린 시간
/// [walkedDistance] 산책 거리(km)
class WalkSummary extends StatelessWidget {
  const WalkSummary({
    super.key,
    required this.screenWidth,
    required this.startedTime,
    required this.walkingRouteFileUrl,
    required this.walkingTime,
    required this.walkedDistance,
  });

  final double screenWidth;
  final DateTime startedTime;
  final String walkingRouteFileUrl;
  final Duration walkingTime;
  final double walkedDistance;

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
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                "${startedTime.toString().split(":")[0]}:${startedTime.toString().split(":")[1]}",
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
                      walkingTime.toString().split(":")[0].length == 1
                          ? "0${walkingTime.toString().split(".")[0]}"
                          : walkingTime.toString().split(".")[0],
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
                      "$walkedDistance Km",
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
                        walkingTime: walkingTime,
                        walkedDistance: walkedDistance,
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
      ],
    );
  }
}
