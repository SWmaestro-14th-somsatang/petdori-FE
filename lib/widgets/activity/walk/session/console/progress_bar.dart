import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooyoungsoo/provider/session_state_provider.dart';

class ProgressBar extends StatefulWidget {
  final int milliSecondCycle;
  final double width;
  final double height;
  double progress;

  ProgressBar({
    super.key,
    required this.milliSecondCycle,
    required this.width,
    required this.height,
    this.progress = 0.5,
  });

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  late Timer timer;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      timer = Timer.periodic(Duration(milliseconds: widget.milliSecondCycle),
          (timer) {
        if (!context.read<SessionStateProvider>().isPaused) {
          setState(() {
            widget.progress += 0.01;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double progress = widget.progress;

    return Stack(
      children: [
        Container(
          height: 10,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 228, 240, 254),
          ),
        ), // decoration: ,
        Container(
          height: 10,
          width: widget.width * progress,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 60, 153, 248),
          ),
        ),
      ],
    );
  }
}
