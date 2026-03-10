/// User entity / DTO for auth and profile.
class UserModel {
  const UserModel({
    this.id,
    this.name,
    this.email,
  });

  final String? id;
  final String? name;
  final String? email;

  // TODO: fromJson, toJson
}
