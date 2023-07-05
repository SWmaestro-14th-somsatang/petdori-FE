import 'package:flutter/material.dart';
import 'package:wooyoungsoo/widgets/social_login_button_widget.dart';

/// 로그인 화면
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.66,
              height: MediaQuery.of(context).size.width * 0.66,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/wooyoungsoo-logo.png'),
                ),
              ),
            ),
            const SosialLoginButton(
              assetName: "assets/images/kakao-logo.svg",
              buttonText: "Kakao 계정으로 로그인",
              buttonColor: 0xFFFEE500,
              textColor: 0xFF191919,
            ),
            const SizedBox(
              height: 8,
            ),
            const SosialLoginButton(
              assetName: "assets/images/google-logo.svg",
              buttonText: "Google 계정으로 로그인",
              buttonColor: 0xFFFFFFFF,
              textColor: 0xFF191919,
            ),
            const SizedBox(
              height: 8,
            ),
            const SosialLoginButton(
              assetName: "assets/images/apple-logo.svg",
              buttonText: "Apple 계정으로 로그인",
              buttonColor: 0xFF000000,
              textColor: 0xFFFFFFFF,
            ),
          ],
        ),
      ),
    );
  }
}
