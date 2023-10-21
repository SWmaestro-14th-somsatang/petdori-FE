import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 회원가입 시 사용되는 이메일 필드 위젯
///
/// [_email] 이메일 필드 위젯의 이메일
/// [_provider] 이메일 필드 위젯의 제공자(카카오, 구글, 애플)
class SignupEmailField extends StatelessWidget {
  const SignupEmailField({
    super.key,
    required String email,
    required String provider,
  })  : _email = email,
        _provider = provider;

  final String _email, _provider;

  @override
  Widget build(BuildContext context) {
    // 화면 너비
    final double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController emailController = TextEditingController(text: _email);

    return Container(
      width: screenWidth * 0.9,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "이메일",
            style: TextStyle(
              color: blackColor,
              fontSize: 14.0,
              fontWeight: fontWeightMedium,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 46,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: lightGreyColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                ProviderIcon(provider: _provider),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  _email,
                  style: const TextStyle(
                    fontSize: 14,
                    color: mediumGreyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
