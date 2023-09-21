import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooyoungsoo/provider/gps_util_provider.dart';
import 'package:wooyoungsoo/provider/session_state_provider.dart';
import 'package:wooyoungsoo/screens/activity/walk/walk_session_screen.dart';
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
    context.read<GpsUtilProvider>().isGpsOnAndGetPermission();

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
          if (context.watch<SessionStateProvider>().isStartted)
            Positioned(
              top: 0,
              left: 0,
              width: screenWidth,
              height: screenHeight,
              child: const WalkSessionScreen(),
            ),
        ],
      ),
    );
  }
}
