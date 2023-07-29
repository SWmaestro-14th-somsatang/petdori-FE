class LoginSuccessResponseModel {
  String accessToken;
  String refreshToken;

  LoginSuccessResponseModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginSuccessResponseModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}
