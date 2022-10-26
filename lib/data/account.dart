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

  Map toJsonNewActivePlan(String newActivePlan) => {
        'email': email,
        'password': password,
      };

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
