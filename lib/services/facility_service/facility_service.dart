import 'package:dio/dio.dart';
import 'package:wooyoungsoo/models/base_response_model.dart';
import 'package:wooyoungsoo/models/facility_model.dart';
import 'package:wooyoungsoo/services/storage_service/storage_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 위치 기반 반려견 시설 조회 관련 기능을 위한 서비스(싱글턴)
class FacilityService {
  final Dio dio = Dio();
  final storageService = StorageService();

  // private한 생성자 생성 => public 생성자가 없어짐
  FacilityService._privateConstructor();
  static final FacilityService _instance =
      FacilityService._privateConstructor();

  factory FacilityService() {
    return _instance;
  }

  Future<List<FacilityModel>> getNearbyFacilities(
      {latitude, longitude, radius}) async {
    try {
      var accessToken = await storageService.getValue(key: "accessToken");

      var res = await dio.get(
        "$baseURL/api/facility/nearby-facilities?keyword=동물병원",
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
        data: {
          "latitude": latitude,
          "longitude": longitude,
          "radius": radius,
        },
      );

      var nearbyFacilitiesResponse = BaseResponseModel.fromJson(res.data);

      return List<FacilityModel>.from(nearbyFacilitiesResponse.data
          .map((facility) => FacilityModel.fromJson(facility)));
    } on DioException {
      return [];
    }
  }
}
