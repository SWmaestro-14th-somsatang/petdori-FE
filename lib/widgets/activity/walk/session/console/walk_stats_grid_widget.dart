import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooyoungsoo/provider/session_stats_provider.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/console/stats/stats_frame_widget.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/console/stats/stats_value_widget.dart';

class WalkStatsGridWidget extends StatelessWidget {
  const WalkStatsGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> statsList = [
      StatsFrameWidget(
        title: "산책 시간",
        child: StatsValueWidget(
          milliSecondCycle: elapsedTimeStatsUpdateCycle,
          getter: context.read<SessionStatsProvider>().getElapsedTime,
        ),
      ),
      StatsFrameWidget(
        title: "거리(Km)",
        child: StatsValueWidget(
          milliSecondCycle: distanceStatsUpdateCycle,
          getter: context.read<SessionStatsProvider>().getDistance,
        ),
      ),
      StatsFrameWidget(
        title: "평균 속력",
        child: StatsValueWidget(
          milliSecondCycle: speedStatsUpdateCycle,
          getter: context.read<SessionStatsProvider>().getSpeed,
        ),
      ),
    ];

    return Container(
        color: Colors.white,
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [statsList[0], statsList[1], statsList[2]]),
          ],
        ));
  }
}
