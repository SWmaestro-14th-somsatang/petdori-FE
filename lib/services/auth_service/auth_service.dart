import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wooyoungsoo/models/profile_model.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/models/base_response_model.dart';
import 'package:wooyoungsoo/services/auth_service/resource_server/apple_server.dart';
import 'package:wooyoungsoo/services/auth_service/resource_server/google_server.dart';
import 'package:wooyoungsoo/services/auth_service/resource_server/kakao_server.dart';
import 'package:wooyoungsoo/services/auth_service/resource_server/resource_server.dart';
import 'package:wooyoungsoo/services/storage_service/storage_service.dart';

/// 회원가입, 로그인, 프로필 조회 등을 담당하는 서비스(싱글턴)
///
/// [storageService] 로컬 저장소에 접근하기 위한 필드
/// [resourceServer] 사용할 ResourceServer (구글, 카카오, 애플)
/// [dio] http 통신을 위한 dio 인스턴스
class AuthService {
  final storageService = StorageService();
  ResourceServer? resourceServer;
  Dio dio = Dio();

  // private한 생성자 생성 => public 생성자가 없어짐
  AuthService._privateConstructor() {
    resourceServer = null;
  }
  static final AuthService _instance = AuthService._privateConstructor();

  factory AuthService() {
    return _instance;
  }

  Future<ProfileModel?> getProfile({String? accessToken}) async {
    accessToken ??= await storageService.getValue(key: 'accessToken');
    if (accessToken == null) {
      return null;
    }
    try {
      var res = await dio.get(
        "$baseURL/api/auth/profile",
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      return ProfileModel.fromJson(res.data["data"]);
    } on DioException {
      return null;
    }
  }

  Future signup({
    required BuildContext context,
    required String oauth2Provider,
    required FormData formData,
  }) async {
    try {
      var res = await dio.post(
        "$baseURL/api/auth/signup?provider=$oauth2Provider",
        data: formData,
      );

      var signupResponse = BaseResponseModel.fromJson(res.data);
      if (signupResponse.status == "success") {
        String accessToken = signupResponse.data["access_token"];
        String refreshToken = signupResponse.data["refresh_token"];
        setTokens(accessToken: accessToken, refreshToken: refreshToken);

        ProfileModel? profile = await getProfile(accessToken: accessToken);
        if (profile != null) {
          setUserName(profile.name);
        }

        goToHomeScreen(context);
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
      debugPrint("resourceServer is null");
      showMessageDialog(context, "로그인 오류", "서버와의 연결에 실패했습니다. 다시 시도해주세요");
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
      setTokens(accessToken: accessToken, refreshToken: refreshToken);

      ProfileModel? profile = await getProfile(accessToken: accessToken);
      if (profile != null) {
        setUserName(profile.name);
      }

      goToHomeScreen(context);
      return;
    }

    if (loginResponse.message == "이메일에 해당하는 유저가 없습니다") {
      var email = loginResponse.data["email"];
      var resourceServerName = getCurrentResourceServerName();
      goToSignupScreen(context, email, resourceServerName);
      return;
    }

    if (loginResponse.status == "error") {
      showMessageDialog(context, "로그인 실패", loginResponse.message);
      return;
    }
  }

  Future logout(BuildContext context) async {
    await storageService.deleteAllValues();
    goToLoginScreen(context);
    return;
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

  void setTokens(
      {required String accessToken, required String refreshToken}) async {
    await storageService.setValue(key: 'accessToken', value: accessToken);
    await storageService.setValue(key: 'refreshToken', value: refreshToken);
  }

  void setUserName(String userName) async {
    await storageService.setValue(key: 'userName', value: userName);
  }

  void goToHomeScreen(BuildContext context) async {
    Navigator.of(context).pushReplacementNamed("/");
  }

  void goToSignupScreen(
      BuildContext context, String email, String resourceServerName) {
    Navigator.of(context).pushNamed("/signup", arguments: {
      "email": email,
      "resourceServerName": resourceServerName,
    });
  }

  void goToLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed("/login");
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
      var res = await dio.post(
        "$baseURL/api/auth/reissue",
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
        debugPrint("accessToken: $accessToken");
        var refreshToken = reissueResponse.data["refresh_token"];
        setTokens(accessToken: accessToken, refreshToken: refreshToken);

        String? userName = await storageService.getValue(key: 'userName');
        if (userName == null) {
          ProfileModel? profile = await getProfile(accessToken: accessToken);
          if (profile != null) {
            setUserName(profile.name);
          } else {
            return;
          }
        }

        goToHomeScreen(context);
        return;
      }
    } on DioException {}

    await storageService.deleteAllValues();
  }
}
