class User {
  late String _id,
      name,
      email,
      role,
      profilePicture,
      hochschule,
      courseOfStudy,
      semester,
      branche;

  User(this._id, this.name, this.email, this.role, this.profilePicture,
      this.hochschule, this.courseOfStudy, this.semester, this.branche);

  User.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    name = importMap['name'] ?? '';
    email = importMap['email'] ?? '';
    role = importMap['role'] ?? '';
    profilePicture = importMap['profilePicture'] ?? '';
    hochschule = importMap['university'] ?? '';
    courseOfStudy = importMap['courseOfStudy'] ?? '';
    semester = importMap['semester'] ?? '';
    branche = importMap['industry'] ?? '';
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
        'profilePicture': profilePicture,
        'courseOfStudy': courseOfStudy,
        'semester': semester,
        'industry': branche,
      };
}
