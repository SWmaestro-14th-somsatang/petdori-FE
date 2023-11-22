import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooyoungsoo/provider/session_stats_provider.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/console/progress_bar.dart';

class WalkGoalGraphWidget extends StatelessWidget {
  final double width;
  final double height;

  const WalkGoalGraphWidget(
      {super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 242, 242, 242)),
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("목표 시간"),
          ProgressBar(
            milliSecondCycle: 5000,
            width: width - 80,
            height: height,
            progress: context.watch<SessionStatsProvider>().progress,
          ),
          const Text("목표 거리"),
          ProgressBar(
            milliSecondCycle: 5000,
            width: width - 80,
            height: height,
            progress: 0.1,
          ),
        ],
      ),
    );
  }
}
