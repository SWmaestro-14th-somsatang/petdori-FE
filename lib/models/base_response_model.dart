class BaseResponseModel {
  String status;
  dynamic data;
  String? message;

  BaseResponseModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) {
    return BaseResponseModel(
      status: json["status"],
      data: json["data"],
      message: json["message"],
    );
  }
}
