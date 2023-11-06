import 'package:flutter/material.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/console/walk_control_buttons_widget.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/console/walk_goal_graph_widget.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/console/walk_stats_grid_widget.dart';

class ActivityConsole extends StatelessWidget {
  const ActivityConsole({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: WalkStatsGridWidget(),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: WalkGoalGraphWidget(
            width: 400,
            height: 100,
          ),
        ),
        WalkControlButtonsWidget(),
      ],
    );
  }
}
