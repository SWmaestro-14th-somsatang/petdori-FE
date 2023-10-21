import 'package:dio/dio.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:wooyoungsoo/models/base_response_model.dart';
import 'package:wooyoungsoo/services/auth_service/resource_server/resource_server.dart';

class AppleServer implements ResourceServer {
  late AuthorizationCredentialAppleID? credential;

  @override
  Future<BaseResponseModel?> login() async {
    await dotenv.load(fileName: ".env");
    var cliendId = dotenv.env['CLIENT_ID'];
    var redirectUri = dotenv.env['APPLE_REDIRECT_URI'];
    try {
      credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: cliendId!,
          redirectUri: Uri.parse(
            redirectUri!,
          ),
        ),
      );
    } catch (error) {
      print(error);
    }

    if (isCredentialReceived()) {
      var loginResponse = await receiveJwtByOauthToken();
      return loginResponse;
    }
    return null;
  }

  /// 애플 유저정보를 잘 받았는지 확인하는 메서드
  bool isCredentialReceived() {
    try {
      credential.toString();
      return credential != null;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<BaseResponseModel> receiveJwtByOauthToken() async {
    final identityToken = credential!.identityToken;
    final dio = Dio();
    try {
      var res = await dio.post("$baseURL/api/auth/login?provider=apple",
          data: {"oauth2_token": identityToken});
      return BaseResponseModel.fromJson(res.data);
    } on DioException catch (e) {
      return BaseResponseModel.fromJson(e.response!.data);
    }
  }
}
