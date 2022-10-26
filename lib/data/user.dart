class User {
  late String _id, name, email, role, profilePicture;

  User(this._id, this.name, this.email, this.role, this.profilePicture);

  User.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    name = importMap['name'] ?? '';
    email = importMap['email'] ?? '';
    role = importMap['role'] ?? '';
    profilePicture = importMap['profilePicture'] ?? '';
  }

  String get getId {
    return _id;
  }

  set setId(String id) {
    _id = id;
  }

  Map toJson(String password) => {
        'name': name,
        'email': email,
        'password': password,
        'profilePicture': profilePicture
      };
}
