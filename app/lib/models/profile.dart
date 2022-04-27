class Profile {
  final String firstName;
  final String lastName;
  final String thumbnailPath;
  final String biography;

  const Profile(
      this.firstName, this.lastName, this.thumbnailPath, this.biography);

  Profile.fromJson(Map<String, dynamic> json)
      : firstName = json['firstname'],
        lastName = json['lastname'],
        thumbnailPath = json["picture"],
        biography = json["biography"];
}
