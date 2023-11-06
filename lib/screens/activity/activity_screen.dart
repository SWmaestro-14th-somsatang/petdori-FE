import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooyoungsoo/provider/gps_util_provider.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/activity/activity_contsole.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/map/map_widget.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double mapHeight = screenHeight * mapHeightRatio;

    context.read<GpsUtilProvider>().isGpsOnAndGetPermission();

    return Scaffold(
      backgroundColor: screenBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            width: screenWidth,
            height: mapHeight,
            child: const MapWidget(),
          ),
          Positioned(
            top: mapHeight - 50,
            left: 0,
            width: screenWidth,
            height: screenHeight - mapHeight + 50,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const ActivityConsole(),
            ),
          ),
        ],
      ),
    );
  }
}
