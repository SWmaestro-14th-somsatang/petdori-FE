import 'package:flutter/material.dart';
import 'package:wooyoungsoo/services/auth_service/auth_service.dart';
import 'package:wooyoungsoo/services/auth_service/resource_server/apple_server.dart';
import 'package:wooyoungsoo/services/auth_service/resource_server/google_server.dart';
import 'package:wooyoungsoo/services/auth_service/resource_server/kakao_server.dart';
import 'package:wooyoungsoo/services/storage_service/storage_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/login_screen/social_login_button_widget.dart';

/// 로그인 화면
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StorageService storageService = StorageService();
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러옴
    // 데이터가 없을때는 null을 반환
    var accessToken = await storageService.getValue(key: "accessToken");
    var refreshToken = await storageService.getValue(key: 'refreshToken');

    // user의 정보가 있다면 홈화면으로 보냄
    if (accessToken != null && refreshToken != null) {
      authService.reIssueToken(context, accessToken, refreshToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 화면 너비
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: screenBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth * 0.66,
              height: screenWidth * 0.66,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(appLogoPath),
                ),
              ),
            ),
            SosialLoginButton(
              assetName: "assets/images/kakao-logo.svg",
              buttonText: "Kakao 계정으로 로그인",
              buttonColor: kakaoButtonColor,
              textColor: kakaoTextColor,
              onPressed: () {
                authService.setResourceServer(KakaoServer());
                authService.login(context);
              },
            ),
            const SizedBox(
              height: 8,
            ),
            SosialLoginButton(
              assetName: "assets/images/google-logo.svg",
              buttonText: "Google 계정으로 로그인",
              buttonColor: googleButtonColor,
              textColor: googleTextColor,
              onPressed: () {
                authService.setResourceServer(GoogleServer());
                authService.login(context);
              },
            ),
            const SizedBox(
              height: 8,
            ),
            SosialLoginButton(
              assetName: "assets/images/apple-logo.svg",
              buttonText: "Apple 계정으로 로그인",
              buttonColor: appleButtonColor,
              textColor: appleTextColor,
              onPressed: () {
                authService.setResourceServer(AppleServer());
                authService.login(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
