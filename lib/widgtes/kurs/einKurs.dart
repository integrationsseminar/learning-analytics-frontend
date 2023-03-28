import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:learning_analytics/app.dart';
import 'package:learning_analytics/data/course.dart';
import 'package:learning_analytics/data/http_helper.dart';
import 'package:learning_analytics/views_d/meine_kurse.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/profil/eineTrophaeen.dart';
import 'package:learning_analytics/widgtes/shared/divider.dart';
import '../../data/user.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EinKurs extends StatefulWidget {
  final Course course;
  const EinKurs({Key? key, required this.course}) : super(key: key);

  @override
  State<EinKurs> createState() => _EinKursState();
}

class _EinKursState extends State<EinKurs> {
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
                  height: 300,
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
                                    width: 180,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 0.0, 20.0, 0.0),
                                        child: RichText(
                                          text: WidgetSpan(
                                            child: Text(
                                              widget.course.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                              textAlign: TextAlign.end,
                                            ),
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
                                  width: 180,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 20.0, 0.0),
                                      child: RichText(
                                        text: WidgetSpan(
                                          child: Text(
                                            widget.course
                                                .universityName, //widget.course.hochschule
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
                                    width: 180,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 0.0, 20.0, 0.0),
                                        child: RichText(
                                          text: WidgetSpan(
                                            child: Text(
                                              widget.course
                                                  .className, //widget.course.studiengang
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                              textAlign: TextAlign.end,
                                            ),
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
                                        child: RichText(
                                          text: WidgetSpan(
                                            child: Text(
                                              createLink(widget.course.getId),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                              ]),

                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 0.0),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      height: 32.0,
                                      minWidth: 120.0,
                                      color: Theme.of(context).highlightColor,
                                      textColor: Colors.black,
                                      onPressed: () => {
                                        Clipboard.setData(ClipboardData(
                                            text: createLink(
                                                widget.course.getId)))
                                      },
                                      splashColor: Colors.redAccent,
                                      child: Text(
                                        "Link kopieren",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
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
                                      onPressed: () async {
                                        deleteCourse(widget.course.getId);
                                      },
                                      splashColor: Colors.redAccent,
                                      child: Text(
                                        "Kurs löschen",
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

  void deleteCourse(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    jwt ??=
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2NjY4MDkzNTksImV4cCI6MTY2NjgyMzc1OX0.hPw63fzL_GP_hYpMwuaxpYbyxqSCtw4Su91s9ge51Qk";
    if (await httpHelper.deleteCourse(jwt, courseId)) {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => (App(
                    currentIndex: 2,
                  ))));
    } else {
      showInSnackbar(context, "Löschen des Kurses fehlgeschlagen!");
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
