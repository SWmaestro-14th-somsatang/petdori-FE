import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooyoungsoo/provider/walk_state_provider.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/activity/walk/map_widget.dart';

class WalkConsoleScreen extends StatelessWidget {
  const WalkConsoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPaused = context.watch<WalkStateProvider>().isPaused;
    bool isExpanded = context.watch<WalkStateProvider>().isExpanded;
    double mapHeight = screenHeight * 0.34;
    double consoleHeight = screenHeight * 0.66;
    return Stack(
      children: [
        AnimatedPositioned(
          top: mapHeight,
          left: 0,
          width: screenWidth,
          height: consoleHeight,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          // child: const PlayConsoleWidget(),
          child: Container(
            color: Colors.amber,
          ),
        ),
        AnimatedPositioned(
          top: 0,
          left: 0,
          width: screenWidth,
          height: isExpanded ? screenHeight : mapHeight,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          child: const MapWidget(),
        ),
      ],
    );
  }
}
