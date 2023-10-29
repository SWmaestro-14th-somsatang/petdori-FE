class DogInfoModel {
  int dogId;
  String dogName;
  String dogTypeName;
  String? dogImageUrl;

  DogInfoModel({
    required this.dogId,
    required this.dogName,
    required this.dogTypeName,
    required this.dogImageUrl,
  });

  factory DogInfoModel.fromJson(Map<String, dynamic> json) {
    return DogInfoModel(
      dogId: json["dog_id"],
      dogName: json["dog_name"],
      dogTypeName: json["dog_type_name"],
      dogImageUrl: json["dog_image_url"],
    );
  }
}
