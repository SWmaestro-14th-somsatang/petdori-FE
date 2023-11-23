class RecentlyWalkLogModel {
  DateTime walkDate;
  double totalWalkedDistance;

  RecentlyWalkLogModel({
    required this.walkDate,
    required this.totalWalkedDistance,
  });

  factory RecentlyWalkLogModel.fromJson(Map<String, dynamic> json) {
    return RecentlyWalkLogModel(
      walkDate: DateTime.parse(json["walk_date"]),
      totalWalkedDistance: json["total_walked_distance"],
    );
  }
}
