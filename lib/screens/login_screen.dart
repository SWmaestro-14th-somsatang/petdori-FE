import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/social_login_button_widget.dart';

/// 로그인 화면
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.66,
              height: MediaQuery.of(context).size.width * 0.66,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(appLogoPath),
                ),
              ),
            ),
            const SosialLoginButton(
              assetName: "assets/images/kakao-logo.svg",
              buttonText: "Kakao 계정으로 로그인",
              buttonColor: kakaoButtonColor,
              textColor: kakaoTextColor,
            ),
            const SizedBox(
              height: 8,
            ),
            const SosialLoginButton(
              assetName: "assets/images/google-logo.svg",
              buttonText: "Google 계정으로 로그인",
              buttonColor: googleButtonColor,
              textColor: googleTextColor,
            ),
            const SizedBox(
              height: 8,
            ),
            const SosialLoginButton(
              assetName: "assets/images/apple-logo.svg",
              buttonText: "Apple 계정으로 로그인",
              buttonColor: appleButtonColor,
              textColor: appleTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
