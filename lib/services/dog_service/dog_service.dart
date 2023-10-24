import 'package:dio/dio.dart';
import 'package:wooyoungsoo/models/base_response_model.dart';
import 'package:wooyoungsoo/services/storage_service/storage_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 반려견 CRUD 관련 기능을 위한 서비스(싱글턴)
class DogService {
  final Dio dio = Dio();
  final storageService = StorageService();

  // private한 생성자 생성 => public 생성자가 없어짐
  DogService._privateConstructor();
  static final DogService _instance = DogService._privateConstructor();

  factory DogService() {
    return _instance;
  }

  Future<List<String>> getDogTypes() async {
    try {
      var res = await dio.get(
        "$baseURL/api/dog/dog-types",
      );

      var dogTypesResponse = BaseResponseModel.fromJson(res.data);
      return List<String>.from(dogTypesResponse.data);
    } on DioException {
      return [];
    }
  }

  Future registerDog({required FormData formData}) async {
    try {
      var accessToken = await storageService.getValue(key: "accessToken");

      var res = await dio.post(
        "$baseURL/api/dog/register",
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer $accessToken",
          },
        ),
        data: formData,
      );

      var dogRegisterResponse = BaseResponseModel.fromJson(res.data);

      // TODO : 에러 처리 및 등록 성공 후 이어질 페이지 연결이 필요
    } on DioException {
      return;
    }
  }
}
