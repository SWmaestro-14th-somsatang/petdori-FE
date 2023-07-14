import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class SocialLoginService {
  late OAuthToken kakaoOauthToken;

  Future<void> signInWithKakao() async {
    if (await isKakaoTalkInstalled()) {
      try {
        kakaoOauthToken = await UserApi.instance.loginWithKakaoTalk();
      } catch (error) {
        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          kakaoOauthToken = await UserApi.instance.loginWithKakaoAccount();
        } catch (error) {
          return;
        }
      }
    } else {
      try {
        kakaoOauthToken = await UserApi.instance.loginWithKakaoAccount();
      } catch (error) {
        return;
      }
    }
    // TODO(Cho-SangHyun): 추후 실제 jwt를 리턴하도록 수정해야 함
    if (isOauthTokenReceived()) {
      var accessToken = receiveJwtByOauthToken();
      print(accessToken);
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

  /// 백엔드에서 JWT 토큰을 받아오는 메서드
  // TODO(Cho-SangHyun): 추후 실제 백엔드와 연동해 jwt를 받아오도록 해야 함
  String receiveJwtByOauthToken() {
    var kakaoAccessToken = kakaoOauthToken.accessToken;
    var accessToken = "from our server";
    return accessToken;
  }
}
