import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wooyoungsoo/models/base_response_model.dart';
import 'package:wooyoungsoo/services/member_service/google_login_service.dart';
import 'package:wooyoungsoo/services/member_service/kakao_login_service.dart';
import 'package:wooyoungsoo/services/member_service/social_login_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/login_screen/social_login_button_widget.dart';

/// 로그인 화면
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final storage = const FlutterSecureStorage();
  late SocialLoginService socialLoginService;

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
    var accessToken = await storage.read(key: "accessToken");
    var refreshToken = await storage.read(key: 'refreshToken');

    // user의 정보가 있다면 홈화면으로 보냄
    if (refreshToken != null) {
      try {
        Dio dio = Dio();
        var res = await dio.post(
          "http://localhost:8080/api/auth/reissue",
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $accessToken"
            },
          ),
          data: {
            "refresh_token": refreshToken,
          },
        );

        var reissueResponse = BaseResponseModel.fromJson(res.data);
        if (reissueResponse.status == "success") {
          var accessToken = reissueResponse.data["access_token"];
          var refreshToken = reissueResponse.data["refresh_token"];
          goToHomeScreen(context, accessToken, refreshToken);
          return;
        }
      } on DioException {}

      // 최초 접속시 토큰 재발급 실패하면 자동로그인 해제. 즉 스토어에 있는걸 다 지운다
      await storage.deleteAll();
    }
  }

  void goToHomeScreen(
      BuildContext context, String accessToken, String refreshToken) async {
    await storage.write(key: 'accessToken', value: accessToken);
    await storage.write(key: 'refreshToken', value: refreshToken);
    Navigator.of(context).pushReplacementNamed("/");
  }

  void goToSignupScreen(
      BuildContext context, String email, String oauth2Provider) {
    Navigator.of(context).pushNamed("/signup", arguments: {
      "email": email,
      "oauth2Provider": oauth2Provider,
    });
  }

  void showMessageDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("로그인 실패"),
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("확인"),
            ),
          ),
        ],
      ),
    );
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
                socialLoginService = KakaoLoginService(
                    loginSuccessCallback:
                        (String accessToken, String refreshToken) =>
                            goToHomeScreen(context, accessToken, refreshToken),
                    loginFailureCallback:
                        (String email, String oauth2Provider) =>
                            goToSignupScreen(context, email, oauth2Provider),
                    diaglogCallback: (String message) =>
                        showMessageDialog(context, message));
                socialLoginService.login();
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
                socialLoginService = GoogleLoginService(
                    loginSuccessCallback:
                        (String accessToken, String refreshToken) =>
                            goToHomeScreen(context, accessToken, refreshToken),
                    loginFailureCallback:
                        (String email, String oauth2Provder) =>
                            goToSignupScreen(context, email, oauth2Provder),
                    diaglogCallback: (String message) =>
                        showMessageDialog(context, message));
                socialLoginService.login();
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
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
