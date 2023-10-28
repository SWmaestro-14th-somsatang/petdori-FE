import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wooyoungsoo/utils/constants.dart';

class ProviderIcon extends StatelessWidget {
  const ProviderIcon({
    super.key,
    required String provider,
  }) : _provider = provider;

  final String _provider;

  @override
  Widget build(BuildContext context) {
    String assetName = _provider == "kakao"
        ? "assets/images/kakao-logo.svg"
        : _provider == "google"
            ? "assets/images/google-logo.svg"
            : "assets/images/apple-logo.svg";

    Color iconColor = _provider == "kakao"
        ? kakaoButtonColor
        : _provider == "google"
            ? googleButtonColor
            : appleButtonColor;

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: _provider == "google" ? lightGreyColor : transparentColor,
        ),
        shape: BoxShape.circle, // 원 모양으로 설정
        color: iconColor, // 원의 배경 색상
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: SvgPicture.asset(
          assetName,
          width: 14,
        ),
      ),
    );
  }
}
