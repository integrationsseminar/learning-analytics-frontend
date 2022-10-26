import 'package:learning_analytics/data/threadwithcomments.dart';

import './thread.dart';
import './threadcomment.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String authority = 'learninganalytics.gang-of-fork.de';

  Future<List<Thread>> getThreads(String jwt) async {
    List<Thread> threads = [];

    String newPath = '/threads';
    Uri uri = Uri.https(authority, newPath);

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${jwt}"
    };

    http.Response res = await http.get(uri, headers: headers);

    if (res.statusCode == 200) {
      var response = jsonDecode(res.body);
      for (var threadRes in response) {
        Thread thread = Thread.fromJSON(threadRes);
        threads.add(thread);
      }
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

    String newPath = '/threadcomments\$filter=thread eq ${threadId}';
    Uri uri = Uri.https(authority, newPath);

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${jwt}"
    };

    http.Response res = await http.get(uri, headers: headers);

    if (res.statusCode == 200) {
      var response = jsonDecode(res.body);
      for (var threadcommentsRes in response) {
        Threadcomment threadcomment = Threadcomment.fromJSON(threadcommentsRes);
        threadcomments.add(threadcomment);
      }
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
      "Authorization": "Bearer ${jwt}"
    };

    http.Response response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 201) {
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
      "Authorization": "Bearer ${jwt}"
    };

    http.Response response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
