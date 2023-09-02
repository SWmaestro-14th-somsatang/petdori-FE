import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooyoungsoo/provider/gps_util_provider.dart';
import 'package:wooyoungsoo/provider/session_state_provider.dart';
import 'package:wooyoungsoo/provider/session_stats_provider.dart';

class WalkControlButtonsWidget extends StatelessWidget {
  const WalkControlButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isPaused = context.watch<SessionStateProvider>().isPaused;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.red,
      child: Stack(
        children: [
          AnimatedPositioned(
            top: 0,
            left: isPaused ? screenWidth * 0.15 : screenWidth * 0.5 - 40,
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              width: 80,
              height: 80,
              child: ElevatedButton(
                onLongPress: () => {
                  context.read<SessionStateProvider>().end(),
                  context.read<SessionStatsProvider>().end(),
                  context.read<GpsUtilProvider>().end(),
                },
                onPressed: () => {
                  print("TOUCH stop button"),
                  // context.read<GpsUtilProvider>().dummyPathAdd(),
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: const Color.fromARGB(255, 136, 140, 247),
                ),
                child: const Icon(
                  Icons.stop,
                  size: 40,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            top: 0,
            right: isPaused ? screenWidth * 0.15 : screenWidth * 0.5 - 40,
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              width: 80,
              height: 80,
              child: ElevatedButton(
                onPressed: () => {
                  context.read<SessionStateProvider>().start(),
                  context.read<SessionStatsProvider>().start(),
                  context.read<GpsUtilProvider>().start(),
                  // context
                  //     .read<ConsoleStatusWidgetProvider>()
                  //     .continueTimer(),
                  // context.read<MapWidgetProvider>().start(),
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: const Color.fromARGB(255, 136, 140, 247),
                ),
                child: const Icon(
                  Icons.play_arrow,
                  size: 40,
                ),
              ),
            ),
          ),
          if (!isPaused)
            Positioned(
              top: 0,
              left: screenWidth * 0.5 - 40,
              child: SizedBox(
                width: 80,
                height: 80,
                child: ElevatedButton(
                  onPressed: () => {
                    context.read<SessionStateProvider>().pause(),
                    context.read<SessionStatsProvider>().pause(),
                    context.read<GpsUtilProvider>().pause(),
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.black,
                  ),
                  child: const Icon(
                    Icons.pause,
                    size: 40,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
