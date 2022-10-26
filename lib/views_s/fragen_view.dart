import 'package:flutter/material.dart';
import '../widgtes/lernen/antwort.dart';
import '../widgtes/customappbar.dart';
import '../data/http_helper.dart';
import '../data/threadwithcomments.dart';
import '../data/threadcomment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FragenView extends StatefulWidget {
  FragenView(
      {Key? key, required this.threadwithcomments, required this.courseName})
      : super(key: key);
  Threadwithcomments threadwithcomments;
  final String courseName;

  @override
  State<FragenView> createState() => _FragenViewState();
}

class _FragenViewState extends State<FragenView> {
  late HttpHelper httpHelper;
  late TextEditingController _controller;
  bool fetching = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    httpHelper = HttpHelper();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            color: Theme.of(context).secondaryHeaderColor),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(getDate(widget.threadwithcomments.thread.createdAt),
                  style: Theme.of(context).textTheme.bodySmall)),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(widget.threadwithcomments.thread.title,
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          Row(children: [
            for (var tag in [widget.courseName, "Frage"])
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).highlightColor),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(tag),
                    )),
              )
          ]),
        ]),
      ),
      Expanded(
        child: ListView(children: [
          Column(children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                for (var antwort in widget.threadwithcomments.threadcomments)
                  Row(
                    children: [
                      Expanded(
                        child: Antwort(
                            answer: antwort.message,
                            type: antwort.createdByOwner),
                      ),
                    ],
                  ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Theme.of(context).secondaryHeaderColor,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _controller,
                          maxLines: 3,
                          decoration: const InputDecoration.collapsed(
                              hintText:
                                  "Bitte geben Sie hier Ihre Nachricht ein"),
                        )),
                    Row(
                      children: [
                        Expanded(
                          child: FloatingActionButton.extended(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              icon: Icon(Icons.add),
                              onPressed: () {
                                newMessage();
                              },
                              label: const Text("Nachricht Versenden")),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ]),
      )
    ]));
  }

  void newMessage() async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    jwt ??=
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2NjY4MDkzNTksImV4cCI6MTY2NjgyMzc1OX0.hPw63fzL_GP_hYpMwuaxpYbyxqSCtw4Su91s9ge51Qk";
    Threadcomment threadcomment = Threadcomment("", "", "", _controller.text,
        widget.threadwithcomments.thread.getId, false);
    await httpHelper.postThreadcomment(jwt, threadcomment);
    widget.threadwithcomments.threadcomments = await httpHelper
        .getThreadcomments(widget.threadwithcomments.thread.getId, jwt);
    setState(() {
      _controller.text = "";
    });
  }

  String getDate(String date) {
    DateTime dateLong = DateTime.parse(date);
    DateTime dateShort = DateTime(dateLong.year, dateLong.month, dateLong.day);
    return dateShort.toString().replaceAll("00:00:00.000", "");
  }
}
