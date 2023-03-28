class Account {
  late String email, password;

  Account(this.email, this.password);

  Account.fromJSON(Map<String, dynamic> importMap) {
    email = importMap['email'] ?? '';
    password = importMap['password'] ?? '';
  }

  Map toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  String getEmail() {
    return email;
  }
}

class RegisterAccount {
  late String name, email, password, profilePicture;

  RegisterAccount(this.name, this.email, this.password, this.profilePicture);

  RegisterAccount.fromJSON(Map<String, dynamic> importMap) {
    name = importMap['name'] ?? '';
    email = importMap['email'] ?? '';
    password = importMap['password'] ?? '';
    profilePicture = importMap['profilePicture'] ?? '';
  }

  Map toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'profilePicture': profilePicture,
    };
  }

  String getEmail() {
    return email;
  }
}

class AccountLecturer {
  late String? name;
  late String? email;

  AccountLecturer(this.name, this.email);

  AccountLecturer.fromJSON(Map<String, dynamic> importMap) {
    name = importMap['name'] ?? '';
    email = importMap['email'] ?? '';
  }

  Map toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}

class AccountStudent {
  late String? name;
  late String? email;
  late String? university;
  late String? courseOfStudy;
  late String? semester;
  late String? branche;

  AccountStudent(this.name, this.email, this.university, this.courseOfStudy,
      this.semester, this.branche);

  AccountStudent.fromJSON(Map<String, dynamic> importMap) {
    name = importMap['name'] ?? '';
    email = importMap['email'] ?? '';
    university = importMap['university'] ?? '';
    courseOfStudy = importMap['courseOfStudy'] ?? '';
    semester = importMap['semester'] ?? '';
    branche = importMap['branche'] ?? '';
  }

  Map toJson() {
    return {
      'name': name,
      'email': email,
      'university': university,
      'courseOfStudy': courseOfStudy,
      'semester': semester,
      'branche': branche,
    };
  }
}
