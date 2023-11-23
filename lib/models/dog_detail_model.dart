class DogDetailModel {
  int dogId;
  String dogName;
  String dogTypeName;
  String? dogImageUrl;
  String dogGender;
  bool isNeutered;
  DateTime dogBirth;
  double dogWeight;

  DogDetailModel({
    required this.dogId,
    required this.dogName,
    required this.dogTypeName,
    required this.dogImageUrl,
    required this.dogGender,
    required this.isNeutered,
    required this.dogBirth,
    required this.dogWeight,
  });

  factory DogDetailModel.fromJson(Map<String, dynamic> json) {
    return DogDetailModel(
      dogId: json["dog_id"],
      dogName: json["dog_name"],
      dogTypeName: json["dog_type_name"],
      dogImageUrl: json["dog_image_url"],
      dogGender: json["dog_gender"],
      isNeutered: json["is_neutered"],
      dogBirth: DateTime.parse(json["dog_birth"]),
      dogWeight: json["dog_weight"],
    );
  }
}
