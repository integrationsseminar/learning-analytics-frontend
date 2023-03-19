import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:learning_analytics/data/http_helper.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/profil/eineTrophaeen.dart';
import 'package:learning_analytics/widgtes/shared/divider.dart';
import '../../data/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class NeuerKurs extends StatefulWidget {
  const NeuerKurs({Key? key}) : super(key: key);

  @override
  State<NeuerKurs> createState() => _NeuerKursState();
}

class _NeuerKursState extends State<NeuerKurs> {
  final kursname = TextEditingController();
  final hochschule = TextEditingController();
  final studiengang = TextEditingController();
  bool kursErstellt = false;
  late String courseId = "";
  late HttpHelper httpHelper;

  @override
  void initState() {
    httpHelper = HttpHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(children: const [
        Positioned(
          child: SizedBox(
              height: 160,
              child: CustomAppBar(
                title: "Meine Kurse",
                backToPage: "MeineKurseD",
              )),
        ),
      ]),
      Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 460,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                          color: Theme.of(context).highlightColor,
                          style: BorderStyle.solid,
                          width: 3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Kursname",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                SizedBox(
                                    height: 70,
                                    width: 200,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 0.0, 20.0, 0.0),
                                        child: TextField(
                                          cursorHeight: 5,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                          controller: kursname,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Kursname',
                                          ),
                                        ),
                                      ),
                                    )),
                              ]),
                          const DividerWidget(),
                          //------------------------------------------
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Hochschule",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                SizedBox(
                                    height: 70,
                                    width: 200,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 0.0, 20.0, 0.0),
                                        child: TextField(
                                          cursorHeight: 5,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                          controller: hochschule,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Hochschule',
                                          ),
                                        ),
                                      ),
                                    )),
                              ]),
                          const DividerWidget(),
                          //------------------------------------------
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Studiengang",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                SizedBox(
                                    height: 70,
                                    width: 200,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 0.0, 20.0, 0.0),
                                        child: TextField(
                                          cursorHeight: 5,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                          controller: studiengang,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Kursname',
                                          ),
                                        ),
                                      ),
                                    )),
                              ]),
                          const DividerWidget(),
                          //------------------------------------------
                          /*
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Link",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                SizedBox(
                                    width: 180,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 0.0, 20.0, 0.0),
                                        child: Text(
                                          "https://learning.25910.de",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    )),
                              ]),
*/
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 0.0),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: IgnorePointer(
                                      ignoring: !kursErstellt,
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        height: 32.0,
                                        minWidth: 120.0,
                                        color: Theme.of(context).highlightColor,
                                        textColor: Colors.black,
                                        onPressed: kursErstellt
                                            ? () {
                                                Clipboard.setData(
                                                  ClipboardData(
                                                    text: createLink(courseId),
                                                  ),
                                                );
                                              }
                                            : null,
                                        splashColor: Colors.redAccent,
                                        disabledColor:
                                            Theme.of(context).highlightColor,
                                        disabledTextColor:
                                            Color.fromARGB(255, 255, 255, 255),
                                        child: Text(
                                          "Link kopieren",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      height: 32.0,
                                      minWidth: 120.0,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      textColor: Colors.white,
                                      onPressed: () => {
                                        postCourse(kursname.text,
                                            hochschule.text, studiengang.text),
                                        setState(() {
                                          kursErstellt = true;
                                        }),
                                      },
                                      splashColor: Colors.redAccent,
                                      child: Text(
                                        "Kurs erstellen",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ]))
    ]);
  }

  void postCourse(
      String kursname, String hochschule, String studiengang) async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    jwt ??=
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2NjY4MDkzNTksImV4cCI6MTY2NjgyMzc1OX0.hPw63fzL_GP_hYpMwuaxpYbyxqSCtw4Su91s9ge51Qk";
    http.Response response =
        await httpHelper.postCourse(jwt, kursname, hochschule, studiengang);
    if (response.statusCode == 200) {
      showInSnackbar(context, "Neuer Kurs wurde erstellt.");
      setState(() {
        courseId = json.decode(response.body)['_id'];
      });
    } else {
      showInSnackbar(context, "Neuer Kurs konnte nicht erstellt werden.");
    }
  }

  void showInSnackbar(BuildContext context, String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        content: Text(value),
      ),
    );
  }

  String createLink(String courseId) {
    String url = Uri.base.toString() + "courseLogin" + "?courseId=" + courseId;
    return url.toString();
  }
}
