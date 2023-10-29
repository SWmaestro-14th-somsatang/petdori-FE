import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';

class VersionInfo extends StatelessWidget {
  const VersionInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          "버전 정보",
          style: TextStyle(
            fontSize: 16,
            color: blackColor,
            fontWeight: fontWeightMedium,
          ),
        ),
        Spacer(),
        Text(
          "v1.0.0",
          style: TextStyle(
            fontSize: 16,
            color: mainColor,
            fontWeight: fontWeightRegular,
          ),
        ),
      ],
    );
  }
}
