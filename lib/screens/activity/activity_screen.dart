import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/activity/activity_controller_buttons.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double activityControllerHeight = screenWidth * 0.45;
    final double activityControllerTop =
        screenHeight - activityControllerHeight;

    return Scaffold(
      backgroundColor: screenBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: activityControllerTop,
            left: 0,
            width: screenWidth,
            height: activityControllerHeight,
            child: const ActivityControllerButtons(),
          ),
        ],
      ),
    );
  }
}
