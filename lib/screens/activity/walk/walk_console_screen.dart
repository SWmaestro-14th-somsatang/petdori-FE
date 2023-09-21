import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooyoungsoo/provider/session_state_provider.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/console/console_widget.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/map/map_widget.dart';

class WalkConsoleScreen extends StatelessWidget {
  const WalkConsoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPaused = context.watch<SessionStateProvider>().isPaused;
    bool isExpanded = context.watch<SessionStateProvider>().isExpanded;
    double mapHeight = screenHeight * mapHeightRatio;
    double consoleHeight = screenHeight * consoleHeightRatio;
    return Stack(
      children: [
        Positioned(
          top: mapHeight,
          left: 0,
          width: screenWidth,
          height: consoleHeight,
          child: const ConsoleWidget(),
        ),
        AnimatedPositioned(
          top: 0,
          left: 0,
          width: screenWidth,
          height: isExpanded ? screenHeight : mapHeight,
          duration: animationDuration,
          curve: Curves.fastOutSlowIn,
          child: const MapWidget(),
        ),
      ],
    );
  }
}
