import 'package:wooyoungsoo/models/base_response_model.dart';

abstract class ResourceServer {
  /// 소셜로그인 메서드
  Future<BaseResponseModel?> login();

  /// 백엔드에서 JWT 토큰을 받아오는 메서드
  Future<BaseResponseModel> receiveJwtByOauthToken();
}
