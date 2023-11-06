class MonthlyWalkLogModel {
  int logId;
  String? walkingImageUrl;
  double walkedDistance;
  DateTime startedTime;
  Duration walkingTime;

  MonthlyWalkLogModel({
    required this.logId,
    required this.walkingImageUrl,
    required this.walkedDistance,
    required this.startedTime,
    required this.walkingTime,
  });

  factory MonthlyWalkLogModel.fromJson(Map<String, dynamic> json) {
    List<String> walkingTimeParts = json["walking_time"].split(":");
    return MonthlyWalkLogModel(
      logId: json["id"],
      walkingImageUrl: json["walking_image_url"],
      walkedDistance: json["walked_distance"],
      startedTime: DateTime.parse(json["started_time"]),
      walkingTime: Duration(
        hours: int.parse(walkingTimeParts[0]),
        minutes: int.parse(walkingTimeParts[1]),
        seconds: int.parse(walkingTimeParts[2]),
      ),
    );
  }
}
