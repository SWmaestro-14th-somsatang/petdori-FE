import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';

class GoToAnotherPage extends StatelessWidget {
  const GoToAnotherPage({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Baseline(
          baselineType: TextBaseline.alphabetic,
          baseline: 14,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: blackColor,
              fontWeight: fontWeightMedium,
            ),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: onPressed,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: darkGreyColor,
            size: 16,
          ),
        ),
      ],
    );
  }
}
