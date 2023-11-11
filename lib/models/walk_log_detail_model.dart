class WalkLogDetailModel {
  String walkingRouteFileUrl;
  String? walkingImageUrl;
  double walkedDistance;
  DateTime startedTime;
  Duration walkingTime;
  List<WalkedDogModel> walkedDogs;

  WalkLogDetailModel({
    required this.walkingRouteFileUrl,
    required this.walkingImageUrl,
    required this.walkedDistance,
    required this.startedTime,
    required this.walkingTime,
    required this.walkedDogs,
  });

  factory WalkLogDetailModel.fromJson(Map<String, dynamic> json) {
    List<String> walkingTimeParts = json["walking_time"].split(":");
    return WalkLogDetailModel(
      walkingRouteFileUrl: json["walking_route_file_url"],
      walkingImageUrl: json["walking_image_url"],
      walkedDistance: json["walked_distance"],
      startedTime: DateTime.parse(json["started_time"]),
      walkingTime: Duration(
        hours: int.parse(walkingTimeParts[0]),
        minutes: int.parse(walkingTimeParts[1]),
        seconds: int.parse(walkingTimeParts[2]),
      ),
      walkedDogs: List<WalkedDogModel>.from(
        json["walked_dogs"].map(
          (data) => WalkedDogModel.fromJson(data),
        ),
      ),
    );
  }
}

class WalkedDogModel {
  String dogName;
  String? dogImageUrl;
  int burnedCalorie;

  WalkedDogModel({
    required this.dogName,
    required this.dogImageUrl,
    required this.burnedCalorie,
  });

  factory WalkedDogModel.fromJson(Map<String, dynamic> json) {
    return WalkedDogModel(
      dogName: json["dog_name"],
      dogImageUrl: json["dog_image_url"],
      burnedCalorie: json["burned_calorie"],
    );
  }
}
