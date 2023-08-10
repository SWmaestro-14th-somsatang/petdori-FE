import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wooyoungsoo/models/base_response_model.dart';
import 'package:wooyoungsoo/services/auth_service/resource_server/apple_server.dart';
import 'package:wooyoungsoo/services/auth_service/resource_server/google_server.dart';
import 'package:wooyoungsoo/services/auth_service/resource_server/kakao_server.dart';
import 'package:wooyoungsoo/services/auth_service/resource_server/resource_server.dart';
import 'package:wooyoungsoo/services/storage_service/storage_service.dart';

/// 회원가입 및 로그인 등을 담당하는 서비스(싱글턴)
///
/// [storageService] 로컬 저장소에 접근하기 위한 필드
/// [resourceServer] 사용할 ResourceServer (구글, 카카오, 애플)
class AuthService {
  final storageService = StorageService();
  ResourceServer? resourceServer;

  // private한 생성자 생성 => public 생성자가 없어짐
  AuthService._privateConstructor() {
    resourceServer = null;
  }
  static final AuthService _instance = AuthService._privateConstructor();

  factory AuthService() {
    return _instance;
  }

  Future signup({
    required BuildContext context,
    required email,
    required String oauth2Provider,
    required Map<String, dynamic> data,
  }) async {
    Dio dio = Dio();
    try {
      var res = await dio.post(
        "http://localhost:8080/api/auth/signup?provider=$oauth2Provider",
        data: data,
      );

      var signupResponse = BaseResponseModel.fromJson(res.data);
      if (signupResponse.status == "success") {
        String accessToken = signupResponse.data["access_token"];
        String refreshToken = signupResponse.data["refresh_token"];
        goToHomeScreen(context, accessToken, refreshToken);
        return;
      }
    } on DioException {
      showMessageDialog(
          context, "회원가입 실패", "알 수 없는 이유로 회원가입에 실패했습니다. 다시 시도해주세요");
      return;
    }
  }

  Future login(BuildContext context) async {
    if (resourceServer == null) {
      // TODO: 순수 이메일 로그인 기능을 추가해야 함~
      return;
    }

    BaseResponseModel? loginResponse = await resourceServer!.login();

    if (loginResponse == null) {
      showMessageDialog(context, "로그인 실패", "로그인에 실패했습니다. 한 번 더 시도해주세요");
      return;
    }

    if (loginResponse.status == "success") {
      var accessToken = loginResponse.data["access_token"];
      var refreshToken = loginResponse.data["refresh_token"];
      goToHomeScreen(context, accessToken, refreshToken);
      return;
    }

    if (loginResponse.message == "이메일에 해당하는 유저가 없습니다") {
      var email = loginResponse.data["email"];
      var resourceServerName = getCurrentResourceServerName();
      goToSignupScreen(context, email, resourceServerName);
      return;
    }

    if (loginResponse.message!.startsWith("이미")) {
      showMessageDialog(context, "로그인 실패", loginResponse.message);
      return;
    }
  }

  void setResourceServer(ResourceServer resourceServer) {
    this.resourceServer = resourceServer;
  }

  String getCurrentResourceServerName() {
    if (resourceServer is GoogleServer) {
      return "google";
    }

    if (resourceServer is KakaoServer) {
      return "kakao";
    }

    if (resourceServer is AppleServer) {
      return "apple";
    }

    return "none";
  }

  void goToHomeScreen(
      BuildContext context, String accessToken, String refreshToken) async {
    await storageService.setValue(key: 'accessToken', value: accessToken);
    await storageService.setValue(key: 'refreshToken', value: refreshToken);
    Navigator.of(context).pushReplacementNamed("/");
  }

  void goToSignupScreen(
      BuildContext context, String email, String resourceServerName) {
    Navigator.of(context).pushNamed("/signup", arguments: {
      "email": email,
      "resourceServerName": resourceServerName,
    });
  }

  void showMessageDialog(BuildContext context, String title, String? message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message!),
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

  void reIssueToken(
      BuildContext context, String accessToken, String refreshToken) async {
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

    await storageService.deleteAllValues();
  }
}
