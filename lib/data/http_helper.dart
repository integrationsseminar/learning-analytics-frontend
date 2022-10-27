import './thread.dart';
import './threadcomment.dart';
import './threadwithcomments.dart';
import './survey.dart';
import './course.dart';
import './user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String authority = 'api.learning-analytics.gang-of-fork.de';

  Future<List<Thread>> getThreads(String jwt) async {
    List<Thread> threads = [];

    String newPath = '/threads';
    Uri uri = Uri.https(authority, newPath);

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    http.Response res = await http.get(uri, headers: headers);

    if (res.statusCode == 200) {
      var response = jsonDecode(res.body)['data'];
      threads = response
          .map<Thread>((threadMap) => Thread.fromJSON(threadMap))
          .toList();
    } else {
      throw Exception('Failed to load threads');
    }
    return threads;
  }

  Future<List<Threadwithcomments>> getThreadswithcomments(String jwt) async {
    List<Threadwithcomments> threadwithcomments = [];
    List<Thread> threads = await getThreads(jwt);
    for (var thread in threads) {
      List<Threadcomment> threadcomments =
          await getThreadcomments(thread.getId, jwt);
      threadwithcomments.add(Threadwithcomments(thread, threadcomments));
    }
    return threadwithcomments;
  }

  Future<List<Threadcomment>> getThreadcomments(String threadId, jwt) async {
    List<Threadcomment> threadcomments = [];

    String newPath = '/threadcomments';

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    Uri uri = Uri.parse(
        "https://$authority$newPath?\$filter=thread+eq+cast('$threadId', ObjectId)");

    http.Response res = await http.get(uri, headers: headers);

    if (res.statusCode == 200) {
      var response = jsonDecode(res.body)['data'];
      threadcomments = response
          .map<Threadcomment>(
              (commentMap) => Threadcomment.fromJSON(commentMap))
          .toList();
    } else {
      throw Exception('Failed to load threadcomments');
    }
    return threadcomments;
  }

  Future<bool> postThread(String jwt, Thread thread) async {
    String newPath = '/threads';
    Uri uri = Uri.https(authority, newPath);

    var body = jsonEncode(thread.toJson());

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    http.Response response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> postThreadcomment(
      String jwt, Threadcomment threadcomment) async {
    String newPath = '/threadcomments';
    Uri uri = Uri.https(authority, newPath);

    var body = jsonEncode(threadcomment.toJson());

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    http.Response response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Survey>> getSurveys(String jwt) async {
    List<Survey> surveys = [];

    String newPath = '/surveys';
    Uri uri = Uri.https(authority, newPath);

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    http.Response res = await http.get(uri, headers: headers);

    if (res.statusCode == 200) {
      var response = jsonDecode(res.body)['data'];
      surveys = response
          .map<Survey>((surveyMap) => Survey.fromJSON(surveyMap))
          .toList();
    } else {
      throw Exception('Failed to load surveys');
    }
    return surveys;
  }

  Future<bool> postSurvey(String jwt, Survey survey) async {
    String newPath = '/surveys';
    Uri uri = Uri.https(authority, newPath);

    var body = jsonEncode(survey.toJson());

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    http.Response response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Course>> getCourses(String jwt) async {
    List<Course> courses = [];

    String newPath = '/courses';
    Uri uri = Uri.https(authority, newPath);

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    http.Response res = await http.get(uri, headers: headers);

    if (res.statusCode == 200) {
      var response = jsonDecode(res.body)['data'];
      courses = response
          .map<Course>((courseMap) => Course.fromJSON(courseMap))
          .toList();
    } else {
      throw Exception('Failed to load courses');
    }
    return courses;
  }

  Future<User> getUser(String jwt) async {
    User user;

    String newPath = '/users/my';
    Uri uri = Uri.https(authority, newPath);

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    http.Response res = await http.get(uri, headers: headers);

    if (res.statusCode == 200) {
      var response = jsonDecode(res.body);
      user = User.fromJSON(response);
    } else {
      throw Exception('Failed to load user');
    }
    return user;
  }
}
