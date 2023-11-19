import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooyoungsoo/provider/gps_util_provider.dart';
import 'package:wooyoungsoo/provider/session_state_provider.dart';
import 'package:wooyoungsoo/provider/session_stats_provider.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/count_down_widget.dart';

class WalkControlButtonsWidget extends StatelessWidget {
  const WalkControlButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool started = context.watch<SessionStateProvider>().isStarted;
    bool ready = context.watch<SessionStateProvider>().isReady;
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.center,
      children: [
        if (!ready && !started)
          SizedBox(
            width: 80,
            height: 80,
            child: ElevatedButton(
              onLongPress: () => {},
              onPressed: () => {
                context.read<SessionStateProvider>().ready(),
                context.read<SessionStatsProvider>().ready(),
                context.read<GpsUtilProvider>().ready(),
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.white,
                elevation: 3,
              ),
              child: const Text(
                "시작",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 60, 153, 248),
                ),
              ),
            ),
          ),
        if (ready && !started) const CountDownWidget(),
        if (started) WalkStopAndContinueButtons(width: screenWidth),
      ],
    );
  }
}

class WalkStopAndContinueButtons extends StatefulWidget {
  final double width;
  const WalkStopAndContinueButtons({super.key, required this.width});

  @override
  _WalkStopAndContinueButtonsState createState() =>
      _WalkStopAndContinueButtonsState();
}

class _WalkStopAndContinueButtonsState
    extends State<WalkStopAndContinueButtons> {
  bool _isExpanded = false;
  Duration duration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: widget.width,
      child: Stack(
        children: [
          AnimatedPositioned(
            width: 80,
            height: 80,
            top: 0,
            left: _isExpanded ? 60 : widget.width / 2 - 40,
            duration: duration,
            child: SizedBox(
              width: 80,
              height: 80,
              child: ElevatedButton(
                onLongPress: () => {},
                onPressed: () => {
                  context.read<SessionStateProvider>().start(),
                  context.read<SessionStatsProvider>().start(),
                  context.read<GpsUtilProvider>().start(),
                  setState(() {
                    _isExpanded = !_isExpanded;
                  }),
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.white,
                  elevation: 3,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  size: 40,
                  color: Color.fromARGB(255, 60, 153, 248),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            width: 80,
            height: 80,
            top: 0,
            left: _isExpanded ? widget.width - 140 : widget.width / 2 - 40,
            duration: duration,
            child: SizedBox(
              width: 80,
              height: 80,
              child: ElevatedButton(
                onLongPress: () => {
                  context.read<SessionStateProvider>().end(),
                  context.read<SessionStatsProvider>().end(),
                  context.read<GpsUtilProvider>().end(),
                  setState(() {
                    _isExpanded = !_isExpanded;
                  }),
                  Navigator.pop(context),
                },
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.white,
                  elevation: 3,
                ),
                child: const Icon(
                  Icons.stop,
                  size: 40,
                  color: Color.fromARGB(255, 60, 153, 248),
                ),
              ),
            ),
          ),
          if (!_isExpanded)
            Positioned(
              left: widget.width / 2 - 40,
              child: SizedBox(
                width: 80,
                height: 80,
                child: ElevatedButton(
                  onLongPress: () => {},
                  onPressed: () => {
                    context.read<SessionStateProvider>().pause(),
                    context.read<SessionStatsProvider>().pause(),
                    context.read<GpsUtilProvider>().pause(),
                    context.read<GpsUtilProvider>().dummyPathAdd(),
                    setState(() {
                      _isExpanded = !_isExpanded;
                    }),
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.white,
                    elevation: 3,
                  ),
                  child: const Icon(
                    Icons.pause,
                    size: 40,
                    color: Color.fromARGB(255, 60, 153, 248),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
