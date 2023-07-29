import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:wooyoungsoo/models/login_success_response_model.dart';
import 'package:wooyoungsoo/services/member_service/social_login_service.dart';

/// 카카오 로그인을 구현하는 클래스
///
/// [kakaoOauthToken] 카카오 로그인 성공시 발급받는 토큰
class KakaoLoginService implements SocialLoginService {
  late OAuthToken kakaoOauthToken;

  @override
  Future login() async {
    if (await isKakaoTalkInstalled()) {
      await loginWithKakaotalk();
    } else {
      await loginWithKakaoAccount();
    }
    // TODO(Cho-SangHyun): 추후 실제 jwt를 리턴하도록 수정해야 함
    if (isOauthTokenReceived()) {
      var loginSuccessResponse = await receiveJwtByOauthToken();

      var accessToken = loginSuccessResponse.accessToken;
      var refreshToken = loginSuccessResponse.refreshToken;
      print(accessToken);
      print(refreshToken);
    }
  }

  Future loginWithKakaotalk() async {
    try {
      kakaoOauthToken = await UserApi.instance.loginWithKakaoTalk();
    } catch (error) {
      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      await loginWithKakaoAccount();
    }
  }

  Future loginWithKakaoAccount() async {
    try {
      kakaoOauthToken = await UserApi.instance.loginWithKakaoAccount();
    } catch (error) {
      return;
    }
  }

  /// 토큰을 잘 받아왔는지 확인하는 메서드
  bool isOauthTokenReceived() {
    try {
      kakaoOauthToken.toString();
      return true;
    } catch (error) {
      return false;
    }
  }

  // TODO(Cho-SangHyun): 추후 실제 백엔드와 연동해 jwt를 받아오도록 해야 함
  @override
  Future<LoginSuccessResponseModel> receiveJwtByOauthToken() async {
    var kakaoAccessToken = kakaoOauthToken.accessToken;
    final dio = Dio();
    var res = await dio.post(
        "http://localhost:8080/api/auth/login?provider=kakao",
        data: {"access_token": kakaoAccessToken});
    return LoginSuccessResponseModel.fromJson(res.data);
  }
}
