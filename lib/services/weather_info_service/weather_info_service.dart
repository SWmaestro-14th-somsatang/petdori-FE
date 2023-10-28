import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// 날씨 정보를 받기 위한 서비스(싱글턴)
class WeatherInfoService {
  final Dio dio = Dio();
  final Map<int, String> weather = {
    2: "번개가 치는 중",
    3: "이슬비가 내리는 중",
    5: "비가 내리는 중",
    6: "눈이 오는 중",
    7: "안개가 껴있는 중",
    8: "맑은 날씨",
    9: "흐린 날씨",
  };

  // private한 생성자 생성 => public 생성자가 없어짐
  WeatherInfoService._privateConstructor();
  static final WeatherInfoService _instance =
      WeatherInfoService._privateConstructor();

  factory WeatherInfoService() {
    return _instance;
  }

  Future<int> getWeatherInfo({
    required double latitude,
    required double longitude,
  }) async {
    await dotenv.load(fileName: ".env");
    String weatherApiKey = dotenv.env["WEATHER_API_KEY"] ?? "";

    try {
      var res = await dio.get(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$weatherApiKey",
      );

      var weatherCode = res.data["weather"][0]["id"];
      var weatherId = (weatherCode / 100).toInt() == 8 && weatherCode % 100 != 0
          ? 9
          : (weatherCode / 100).toInt();

      return weatherId;
    } on DioException {
      return 0;
    }
  }
}
