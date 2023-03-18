import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:learning_analytics/data/account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learning_analytics/data/http_helper.dart';

class AccountHttpHelper {
  final String authority = 'api.learning-analytics.gang-of-fork.de';

  Future<bool> postAccount(RegisterAccount account) async {
    final prefs = await SharedPreferences.getInstance();
    String newPath = '/auth/register/63496390b3e7ebc4e3d8cb50';
    Uri uri = Uri.https(authority, newPath);
    var email = account.email;
    var password = account.password;

    var body = jsonEncode(account.toJson());

    var headers = {
      "Content-Type": "application/json",
    };

    http.Response response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 201) {
      var role = json.decode(response.body)["role"];

      await prefs.setString("role", role);
      return await loginAccount(Account(email, password));
    } else {
      return false;
    }
  }

  Future<bool> loginAccount(Account account) async {
    final prefs = await SharedPreferences.getInstance();

    String newPath = '/auth/login';
    Uri uri = Uri.https(authority, newPath);

    var body = jsonEncode(account.toJson());

    var headers = {
      "Content-Type": "application/json",
    };

    http.Response response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      var loginToken = json.decode(response.body)["token"]["token"];
      await prefs.setString("jwt", loginToken);

      var role = (await HttpHelper().getUser(loginToken)).role;
      await prefs.setString("role", role);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> changeName(AccountName account, String? jwt) async {
    String newPath = '/users/my';
    Uri uri = Uri.https(authority, newPath);

    var body = jsonEncode(account.toJson());

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    http.Response response = await http.put(uri, headers: headers, body: body);

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
