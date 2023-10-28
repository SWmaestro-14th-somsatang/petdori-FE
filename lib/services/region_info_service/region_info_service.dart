import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// 행정구역 정보를 받기 위한 서비스(싱글턴)
class RegionInfoService {
  final Dio dio = Dio();

  // private한 생성자 생성 => public 생성자가 없어짐
  RegionInfoService._privateConstructor();
  static final RegionInfoService _instance =
      RegionInfoService._privateConstructor();

  factory RegionInfoService() {
    return _instance;
  }

  Future<String> getRegionInfo({
    required double latitude,
    required double longitude,
  }) async {
    await dotenv.load(fileName: ".env");
    String kakaoRestApiKey = dotenv.env["KAKAO_REST_API_KEY"] ?? "";

    try {
      var res = await dio.get(
        "https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=$longitude&y=$latitude",
        options: Options(
          headers: {
            "Authorization": "KakaoAK $kakaoRestApiKey",
          },
        ),
      );
      var si = res.data["documents"][0]["region_1depth_name"];
      var gu = res.data["documents"][0]["region_2depth_name"];
      // await Future.delayed(const Duration(seconds: 1));
      return si + " " + gu;
    } on DioException {
      return "";
    }
  }
}
