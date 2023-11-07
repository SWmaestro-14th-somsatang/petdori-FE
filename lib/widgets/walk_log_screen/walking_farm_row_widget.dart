import 'package:flutter/material.dart';
import 'package:wooyoungsoo/models/recently_walk_log_model.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 최근 산책 기록 밭 위젯
///
/// [walkLogs] 최근 산책 기록 리스트
class WalkingFarmRow extends StatelessWidget {
  const WalkingFarmRow({
    super.key,
    required this.walkLogs,
  });

  final List<RecentlyWalkLogModel> walkLogs;

  Color getWalkLogColor(double walkedDistance) {
    if (walkedDistance == 0) {
      return blueColorLv1;
    }
    if (walkedDistance < 1) {
      return blueColorLv2;
    }
    if (walkedDistance < 2) {
      return blueColorLv3;
    }
    if (walkedDistance < 3) {
      return blueColorLv4;
    }
    return blueColorLv5;
  }

  Color getDayColor(double walkedDistance) {
    if (walkedDistance < 2) {
      return darkGreyColor;
    }
    return whiteColor;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: getWalkLogColor(walkLogs[index].totalWalkedDistance),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  walkLogs[index].walkDate.day.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: fontWeightBold,
                    color: getDayColor(walkLogs[index].totalWalkedDistance),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 10,
          );
        },
        itemCount: walkLogs.length,
      ),
    );
  }
}
