import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wooyoungsoo/models/facility_model.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 편의시설 상세정보 위젯
///
/// [facility] : 편의시설 정보
/// [width] : 위젯의 너비
/// [height] : 위젯의 높이
/// [dayOfTheWeek] : 요일 정보
class FacilityBottomSheet extends StatelessWidget {
  FacilityBottomSheet({
    Key? key,
    required this.facility,
    required this.width,
    required this.height,
  }) : super(key: key);

  final FacilityModel facility;
  final double width, height;
  final Map<String, String> dayOfTheWeek = {
    "Sun": "일",
    "Mon": "월",
    "Tue": "화",
    "Wed": "수",
    "Thu": "목",
    "Fri": "금",
    "Sat": "토",
  };

  String getCurrentOperatingInfo(String operatingHourInfo) {
    List<String> operatingDayOfTheWeeks =
        operatingHourInfo.split(" ")[0].split(",");
    String openHour = operatingHourInfo.split(" ")[1];
    String closeHour = operatingHourInfo.split(" ")[3];

    var now = DateTime.now();
    String? currentDayOfTheWeek = dayOfTheWeek[DateFormat.E().format(now)];

    if (currentDayOfTheWeek != null &&
        operatingDayOfTheWeeks.contains(currentDayOfTheWeek)) {
      DateTime openTime = DateTime(now.year, now.month, now.day,
          int.parse(openHour.split(":")[0]), int.parse(openHour.split(":")[1]));
      DateTime closeTime = DateTime(
          now.year,
          now.month,
          now.day,
          int.parse(closeHour.split(":")[0]),
          int.parse(closeHour.split(":")[1]));
      if (now.isAfter(openTime) && now.isBefore(closeTime)) {
        return "영업 중";
      }
    }
    return "영업 종료";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              facility.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: fontWeightBold,
                color: blackColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            facility.operatingHourInfo.isEmpty
                ? const SizedBox.shrink()
                : Row(
                    children: [
                      SizedBox(
                        width: 70,
                        child: Text(
                          getCurrentOperatingInfo(facility.operatingHourInfo),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: fontWeightBold,
                            color: redColor,
                          ),
                        ),
                      ),
                      Text(
                        facility.operatingHourInfo,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: fontWeightRegular,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
            facility.operatingHourInfo.isEmpty
                ? const SizedBox.shrink()
                : const SizedBox(
                    height: 10,
                  ),
            Row(
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    facility.distanceInfo,
                    style: const TextStyle(
                      color: blackColor,
                      fontSize: 14,
                      fontWeight: fontWeightBold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    facility.address,
                    style: const TextStyle(
                      color: darkGreyColor,
                      fontSize: 14,
                      fontWeight: fontWeightRegular,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.copy_rounded,
                    color: mainColor,
                    size: 18,
                  ),
                  label: const Text(
                    "복사",
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 14,
                      fontWeight: fontWeightMedium,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
