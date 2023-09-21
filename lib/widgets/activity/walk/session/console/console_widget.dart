import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/console/test_widget.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/console/walk_control_buttons_widget.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/console/walk_stats_grid_widget.dart';

class ConsoleWidget extends StatelessWidget {
  const ConsoleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double consoleHeight = screenHeight * consoleHeightRatio;
    double statsGridHeight = consoleHeight * statsGridHeightRatio;
    double testWidgetHeight = consoleHeight * testWidgetHeightRatio;
    double controlButtonsWidgetHeight =
        consoleHeight * controlButtonsWidgetHeightRatio;
    return Container(
      color: Colors.amber,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            width: screenWidth,
            height: statsGridHeight,
            child: const WalkStatsGridWidget(),
          ),
          Positioned(
            top: statsGridHeight,
            left: 0,
            width: screenWidth,
            height: testWidgetHeight,
            child: const TestWidget(),
          ),
          // 뭔가 힙한 위젯(),

          Positioned(
            top: statsGridHeight + testWidgetHeight,
            left: 0,
            width: screenWidth,
            height: controlButtonsWidgetHeight,
            child: const WalkControlButtonsWidget(),
          ),
        ],
      ),
    );
  }
}
