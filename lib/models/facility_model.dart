class FacilityModel {
  String name;
  String address;
  double latitude;
  double longitude;
  String distanceInfo;
  String operatingHourInfo;

  FacilityModel({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.distanceInfo,
    required this.operatingHourInfo,
  });

  factory FacilityModel.fromJson(Map<String, dynamic> json) {
    return FacilityModel(
      name: json["name"],
      address: json["address"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      distanceInfo: json["distance_info"],
      operatingHourInfo: json["operating_hour_info"],
    );
  }
}
