import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooyoungsoo/provider/session_state_provider.dart';
import 'package:wooyoungsoo/screens/activity/walk/walk_console_screen.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/count_down_widget.dart';

class WalkSessionScreen extends StatelessWidget {
  const WalkSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        color: whiteColor,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              width: screenWidth,
              height: screenHeight,
              child: const WalkConsoleScreen(),
            ),
            if (context.watch<SessionStateProvider>().isReady)
              Positioned(
                top: 0,
                left: 0,
                width: screenWidth,
                height: screenHeight,
                child: const CountDownWidget(),
              ),
          ],
        ),
      ),
    );
  }
}
