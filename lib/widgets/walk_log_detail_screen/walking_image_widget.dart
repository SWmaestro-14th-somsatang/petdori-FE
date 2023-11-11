import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 산책 기록 상세 화면의 산책 사진 위젯
///
/// [screenWidth] 화면의 너비
/// [walkingImageUrl] 산책 사진의 URL
class WalkingImage extends StatelessWidget {
  const WalkingImage({
    super.key,
    required this.screenWidth,
    required this.walkingImageUrl,
  });

  final double screenWidth;
  final String? walkingImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.033,
          ),
          child: const Row(
            children: [
              Text(
                "함께한 사진 📷",
                style: TextStyle(
                  color: blackColor,
                  fontSize: 18,
                  fontWeight: fontWeightBold,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: screenWidth * 0.934,
          height: walkingImageUrl == null ? 200 : 250,
          margin: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: lightGreyColor,
            borderRadius: BorderRadius.circular(10),
            image: walkingImageUrl == null
                ? null
                : DecorationImage(
                    image: NetworkImage(
                      walkingImageUrl!,
                    ),
                    fit: BoxFit.cover,
                  ),
          ),
          alignment: Alignment.center,
          child: walkingImageUrl == null
              ? const Text(
                  "저장된 산책 사진이 없습니다",
                  style: TextStyle(
                    color: darkGreyColor,
                    fontSize: 14,
                    fontWeight: fontWeightRegular,
                  ),
                )
              : null,
        ),
      ],
    );
  }
}
