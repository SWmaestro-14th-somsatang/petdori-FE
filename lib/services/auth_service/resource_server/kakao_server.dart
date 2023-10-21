import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:wooyoungsoo/models/base_response_model.dart';
import 'package:wooyoungsoo/services/auth_service/resource_server/resource_server.dart';

class KakaoServer implements ResourceServer {
  late OAuthToken kakaoOauthToken;

  @override
  Future<BaseResponseModel?> login() async {
    if (await isKakaoTalkInstalled()) {
      await loginWithKakaotalk();
    } else {
      await loginWithKakaoAccount();
    }

    if (isOauthTokenReceived()) {
      var loginResponse = await receiveJwtByOauthToken();
      return loginResponse;
    }

    return null;
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

  @override
  Future<BaseResponseModel> receiveJwtByOauthToken() async {
    var kakaoAccessToken = kakaoOauthToken.accessToken;
    final dio = Dio();

    try {
      var res = await dio.post("$baseURL/api/auth/login?provider=kakao",
          data: {"oauth2_token": kakaoAccessToken});
      return BaseResponseModel.fromJson(res.data);
    } on DioException catch (e) {
      print(e.response);
      return BaseResponseModel.fromJson(e.response!.data);
    }
  }
}
