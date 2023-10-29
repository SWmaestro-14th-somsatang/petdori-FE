class ProfileModel {
  String name;
  String email;
  String provider;
  String? profileImageUrl;

  ProfileModel({
    required this.name,
    required this.email,
    required this.provider,
    required this.profileImageUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json["name"],
      email: json["email"],
      provider: json["provider"],
      profileImageUrl: json["profile_image_url"],
    );
  }
}
