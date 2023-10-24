import 'package:dio/dio.dart';
import 'package:wooyoungsoo/models/base_response_model.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 반려견 CRUD 관련 기능을 위한 서비스(싱글턴)
class DogService {
  final Dio dio = Dio();

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
}
