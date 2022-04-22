class Profile {
  final String firstName;
  final String lastName;
  final String thumbnailPath;
  final String biography;

  const Profile(
      this.firstName, this.lastName, this.thumbnailPath, this.biography);

  Profile.fromJson(Map<String, dynamic> json)
      : firstName = json['first_name'],
        lastName = json['last_name'],
        thumbnailPath = json["profile_picture"],
        biography = json["biography"];
}
