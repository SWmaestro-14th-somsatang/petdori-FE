import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 홈 화면 헤더
///
/// [screenWidth] : 화면 너비
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.033,
      ),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade600,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 1,
                  horizontal: 5,
                ),
                child: Text(
                  "우영수",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: fontWeightMedium,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
