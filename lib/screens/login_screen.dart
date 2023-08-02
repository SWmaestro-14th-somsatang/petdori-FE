import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wooyoungsoo/services/member_service/google_login_service.dart';
import 'package:wooyoungsoo/services/member_service/kakao_login_service.dart';
import 'package:wooyoungsoo/services/member_service/social_login_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/social_login_button_widget.dart';

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
    var refreshToken = await storage.read(key: 'refreshToken');

    // user의 정보가 있다면 홈화면으로 보냄
    if (refreshToken != null) {
      Navigator.of(context).pushReplacementNamed("/");
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

  // TODO(Cho-SangHyun): 추후 기로그인 여부에 따라 바로 홈으로 가도록 해야 함
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
