import 'package:flutter/material.dart';

class StatsFrameWidget extends StatelessWidget {
  final String title;
  final Widget child;
  const StatsFrameWidget({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        child,
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 17,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
