import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 최근 산책 기록 밭 색상 바 위젯
class WalkingFarmColorBar extends StatelessWidget {
  const WalkingFarmColorBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "0km",
          style: TextStyle(
            fontSize: 12,
            fontWeight: fontWeightMedium,
            color: darkGreyColor,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: blueColorLv1,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: blueColorLv2,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: blueColorLv3,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: blueColorLv4,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: blueColorLv5,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        const Text(
          "3km",
          style: TextStyle(
            fontSize: 12,
            fontWeight: fontWeightMedium,
            color: darkGreyColor,
          ),
        ),
      ],
    );
  }
}
