import 'package:dio/dio.dart';
import 'package:wooyoungsoo/models/base_response_model.dart';
import 'package:wooyoungsoo/models/monthly_walk_log_model.dart';
import 'package:wooyoungsoo/services/storage_service/storage_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 산책 기록을 위한 서비스(싱글턴)
class WalkLogService {
  final Dio dio = Dio();
  final storageService = StorageService();

  // private한 생성자 생성 => public 생성자가 없어짐
  WalkLogService._privateConstructor();
  static final WalkLogService _instance = WalkLogService._privateConstructor();

  factory WalkLogService() {
    return _instance;
  }

  Future<List<MonthlyWalkLogModel>> getMonthlyWalkLogs({
    required int year,
    required int month,
  }) async {
    try {
      var accessToken = await storageService.getValue(key: "accessToken");

      var res = await dio.get(
        "$baseURL/api/walk-log/monthly-logs?year=$year&month=$month",
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      var monthlyWalkLogsResponse = BaseResponseModel.fromJson(res.data);

      return List<MonthlyWalkLogModel>.from(
        monthlyWalkLogsResponse.data.map(
          (walkLog) => MonthlyWalkLogModel.fromJson(walkLog),
        ),
      );
    } on DioException {
      return [];
    }
  }
}
