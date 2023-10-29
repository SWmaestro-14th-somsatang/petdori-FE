import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/provider_icon_widget.dart';

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
