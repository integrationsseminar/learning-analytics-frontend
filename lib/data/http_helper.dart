import 'package:learning_analytics/data/progressValues.dart';
import 'package:learning_analytics/data/trophy.dart';

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

    Uri uri = Uri.parse("https://$authority$newPath?\$orderby=createdAt desc");

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

  Future<bool> deleteThread(String jwt, String threadId) async {
    String newPath = '/threads/$threadId';
    Uri uri = Uri.https(authority, newPath);

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    http.Response response = await http.delete(uri, headers: headers);

    if (response.statusCode == 204) {
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

  Future<bool> deleteSurvey(String jwt, String threadId) async {
    String newPath = '/surveys/$threadId';
    Uri uri = Uri.https(authority, newPath);

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    http.Response response = await http.delete(uri, headers: headers);

    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Survey>> getSurveys(String jwt) async {
    List<Survey> surveys = [];

    String newPath = '/surveys';
    Uri uri = Uri.parse("https://$authority$newPath?\$orderby=createdAt desc");

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

  Future<Survey> getSurvey(String jwt, String surveyId) async {
    Survey survey;

    String newPath = '/surveys/$surveyId';
    Uri uri = Uri.https(authority, newPath);

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    http.Response res = await http.get(uri, headers: headers);

    if (res.statusCode == 200) {
      var response = jsonDecode(res.body);
      survey = Survey.fromJSON(response);
    } else {
      throw Exception('Failed to load survey');
    }
    return survey;
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

  Future<bool> submitAnswer(String jwt, String answer, String surveyId) async {
    String newPath = '/surveys/$surveyId/answers';
    Uri uri = Uri.https(authority, newPath);

    var body = jsonEncode(<String, String>{
      'answer': answer,
    });

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    http.Response response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 204) {
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

  Future<Course> getCourse(String jwt, String courseId) async {
    Course course = Course("", "", "", "", "", "", false, "", "");

    String newPath = '/courses/$courseId';
    Uri uri = Uri.https(authority, newPath);

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    http.Response res = await http.get(uri, headers: headers);

    if (res.statusCode == 200) {
      course = Course.fromJSON(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load courses');
    }
    return course;
  }

  Future<http.Response> postCourse(String jwt, String kursname,
      String hochschule, String studiengang) async {
    String newPath = '/courses';
    Course newCourse = Course(
        "",
        kursname,
        "2023-03-16T13:21:40.456Z",
        "2043-03-16T13:21:40.456Z",
        "string",
        "ByDate",
        false,
        hochschule,
        studiengang);
    Uri uri = Uri.https(authority, newPath);
    //DateTime.now().toString(),
    // DateTime.now().add(const Duration(days: 365 * 100)).toString(),
    var body = jsonEncode(newCourse.toJson());

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    http.Response response = await http.post(uri, headers: headers, body: body);

    return response;
  }

  Future<bool> deleteCourse(String jwt, String courseId) async {
    String newPath = '/courses/$courseId';
    Uri uri = Uri.https(authority, newPath);

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    http.Response res = await http.delete(uri, headers: headers);

    if (res.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to delete course');
    }
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

  Future<bool> postLearningprogress(String jwt, List<int> answer) async {
    String newPath = '/learningprogress';
    Uri uri = Uri.https(authority, newPath);

    var body = json.encode({"progressValues": answer});

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

  Future<List<ProgressValues>> getLearningprogress(String jwt) async {
    List<ProgressValues> progressValues = [];

    String newPath = '/learningprogress';

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    Uri uri = Uri.parse("https://$authority$newPath?orderby=data/createdAt");

    //Uri uri = Uri.https(authority, newPath);

    http.Response res = await http.get(uri, headers: headers);

    if (res.statusCode == 200) {
      var response = jsonDecode(res.body)['data'];

      progressValues = response
          .map<ProgressValues>(
              (progressMap) => ProgressValues.fromJSON(progressMap))
          .toList();
    } else {
      throw Exception('Failed to load progress Values.');
    }
    return progressValues;
  }

  Future<List<Trophy>> getUserTrophys(String jwt) async {
    List<Trophy> trophies = [];

    String newPath = '/usertrophys';

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    Uri uri = Uri.https(authority, newPath);

    http.Response res = await http.get(uri, headers: headers);

    if (res.statusCode == 200) {
      var response = jsonDecode(res.body)['data'];
      trophies = response
          .map<Trophy>((trophyMap) => Trophy.fromJSON(trophyMap))
          .toList();
    } else {
      throw Exception('Failed to load trophies.');
    }

    return trophies;
  }

  Future<List<OneOfAllTrophies>> getAllTrophys(String jwt) async {
    List<OneOfAllTrophies> trophies = [];

    String newPath = '/trophys';

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    };

    Uri uri = Uri.https(authority, newPath);

    http.Response res = await http.get(uri, headers: headers);

    if (res.statusCode == 200) {
      var response = jsonDecode(res.body)['data'];
      trophies = response
          .map<OneOfAllTrophies>(
              (trophyMap) => OneOfAllTrophies.fromJSON(trophyMap))
          .toList();
    } else {
      throw Exception('Failed to load trophies.');
    }

    return trophies;
  }
}
