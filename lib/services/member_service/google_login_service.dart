import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wooyoungsoo/services/member_service/social_login_service.dart';

/// 구글 로그인을 구현하는 클래스
///
/// [googleUser] 구글에 로그인한 유저 정보가 담기는 필드
/// [googleAuth] 구글 로그인 성공후 발급된 토큰이 담기는 필드
class GoogleLoginService implements SocialLoginService {
  late GoogleSignInAccount? googleUser;
  late GoogleSignInAuthentication googleAuth;

  @override
  Future login() async {
    googleUser = await GoogleSignIn().signIn();
    // TODO(Cho-SangHyun): 추후 실제 jwt를 리턴하도록 수정해야 함
    if (isGoogleUserReceived()) {
      googleAuth = await googleUser!.authentication;
      var accessToken = await receiveJwtByOauthToken();
      print(accessToken);
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
  Future<String> receiveJwtByOauthToken() async {
    var googleAccessToken = googleAuth.accessToken;
    if (googleAccessToken != null) {
      final dio = Dio();
      var res = await dio.post(
          "http://localhost:8080/api/auth/login?provider=google",
          data: {"accessToken": googleAccessToken});
      var accessToken = "from our server";
      return accessToken;
    }
    // TODO(Cho-SangHyun): 구글토큰이 없는 경우 예외처리 필요
    return "error: google access token does not exist";
  }
}
