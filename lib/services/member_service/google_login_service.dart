import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wooyoungsoo/models/base_response_model.dart';
import 'package:wooyoungsoo/services/member_service/social_login_service.dart';

/// 구글 로그인을 구현하는 클래스
///
/// [googleUser] 구글에 로그인한 유저 정보가 담기는 필드
/// [googleAuth] 구글 로그인 성공후 발급된 토큰이 담기는 필드
class GoogleLoginService implements SocialLoginService {
  late GoogleSignInAccount? googleUser;
  late GoogleSignInAuthentication googleAuth;
  final VoidCallback loginSuccessCallback;
  final Function loginFailureCallback;
  final Function diaglogCallback;

  GoogleLoginService(
      {required this.loginSuccessCallback,
      required this.loginFailureCallback,
      required this.diaglogCallback});

  @override
  Future login() async {
    googleUser = await GoogleSignIn().signIn();
    if (isGoogleUserReceived()) {
      googleAuth = await googleUser!.authentication;
      var loginResponse = await receiveJwtByOauthToken();

      if (loginResponse.status == "success") {
        var accessToken = loginResponse.data["access_token"];
        var refreshToken = loginResponse.data["refresh_token"];
        loginSuccessCallback();
        return;
      }

      if (loginResponse.message == "이메일에 해당하는 유저가 없습니다") {
        var email = loginResponse.data["email"];
        loginFailureCallback(email);
        return;
      }

      if (loginResponse.message!.startsWith("이미")) {
        diaglogCallback(loginResponse.message);
        return;
      }
    }
  }

  /// 구글 유저정보를 잘 받았는지 확인하는 메서드
  bool isGoogleUserReceived() {
    try {
      googleUser.toString();
      return googleUser != null;
    } catch (error) {
      return false;
    }
  }

  // TODO(Cho-SangHyun): 추후 실제 백엔드와 연동해 jwt를 받아오도록 해야 함
  @override
  Future<BaseResponseModel> receiveJwtByOauthToken() async {
    var googleAccessToken = googleAuth.accessToken;
    if (googleAccessToken == null) {
      // TODO(Cho-SangHyun): 구글토큰이 없는 경우 예외처리 필요
      throw Exception("로그인해서 받은 구글 토큰이 없습니다.");
    }

    final dio = Dio();
    try {
      var res = await dio.post(
          "http://localhost:8080/api/auth/login?provider=google",
          data: {"access_token": googleAccessToken});
      return BaseResponseModel.fromJson(res.data);
    } on DioException catch (e) {
      return BaseResponseModel.fromJson(e.response!.data);
    }
  }
}
