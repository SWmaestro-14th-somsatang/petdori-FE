abstract class SocialLoginService {
  /// 소셜로그인 메서드
  Future login();

  /// 백엔드에서 JWT 토큰을 받아오는 메서드
  Future<String> receiveJwtByOauthToken();
}
