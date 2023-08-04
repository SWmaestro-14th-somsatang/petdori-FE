import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wooyoungsoo/models/base_response_model.dart';
import 'package:wooyoungsoo/services/auth_service/resource_server/resource_server.dart';

class GoogleServer implements ResourceServer {
  late GoogleSignInAccount? googleUser;
  late GoogleSignInAuthentication googleAuth;

  @override
  Future<BaseResponseModel?> login() async {
    try {
      googleUser = await GoogleSignIn().signIn();
    } catch (error) {}

    if (isGoogleUserReceived()) {
      googleAuth = await googleUser!.authentication;
      var loginResponse = await receiveJwtByOauthToken();
      return loginResponse;
    }
    return null;
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
