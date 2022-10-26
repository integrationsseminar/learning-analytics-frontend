import 'dart:html';

import 'package:flutter/material.dart';
import 'package:learning_analytics/data/stringEnumAnswerType.dart';
import 'package:learning_analytics/views_s/mein_lernen.dart';
import '../widgtes/lernen/antwort.dart';
import '../widgtes/customappbar.dart';
import '../data/thread.dart';
import '../data/user.dart';
import '../data/course.dart';
import '../data/survey.dart';
import '../data/http_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFrage extends StatefulWidget {
  const AddFrage({Key? key}) : super(key: key);

  @override
  State<AddFrage> createState() => _AddFrageState();
}

class _AddFrageState extends State<AddFrage> {
  late TextEditingController _controllerFrage;
  late TextEditingController _controllerUmfrage;
  late HttpHelper httpHelper;
  late List<Course> courses;
  late Course kursFrage = courses.first;
  late Course kursUmfrage = courses.first;
  late User user;
  bool fetching = true;
  late List<TextEditingController> answerControllers = [
    TextEditingController()
  ];

  @override
  void initState() {
    super.initState();
    _controllerFrage = TextEditingController();
    _controllerUmfrage = TextEditingController();
    httpHelper = HttpHelper();
    fetchData();
  }

  @override
  void dispose() {
    _controllerFrage.dispose();
    _controllerUmfrage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: fetching
            ? const Center(child: CircularProgressIndicator())
            : Column(children: [
                Positioned(
                  child: Container(
                    child: SizedBox(
                        height: 140,
                        child: Container(
                            color: Theme.of(context).secondaryHeaderColor,
                            child: const CustomAppBar(
                                title: "Mein Lernen",
                                backToPage: "MeinLernenS"))),
                  ),
                ),
                //if (user.role != "Student")
                DefaultTabController(
                    length: 2, // length of tabs
                    initialIndex: 0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            child: TabBar(
                              labelColor: Theme.of(context).primaryColor,
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                const Tab(text: 'Frage'),
                                const Tab(text: 'Umfrage'),
                              ],
                            ),
                          ),
                          Container(
                            height: 500,
                            child: TabBarView(children: [
                              //Fragen
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                          width: 2.0,
                                          color:
                                              Theme.of(context).highlightColor,
                                          style: BorderStyle.solid),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(children: [
                                          const Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text("Frage")),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            color: Theme.of(context)
                                                .secondaryHeaderColor,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextField(
                                                  controller: _controllerFrage,
                                                  maxLines: 6,
                                                  decoration: const InputDecoration
                                                          .collapsed(
                                                      hintText:
                                                          "Bitte geben Sie hier Ihre Frage ein"),
                                                )),
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Kurs"),
                                                DropdownButton(
                                                    value: kursFrage,
                                                    items: courses.map<
                                                            DropdownMenuItem<
                                                                Course>>(
                                                        (Course course) {
                                                      return DropdownMenuItem<
                                                          Course>(
                                                        value: course,
                                                        child:
                                                            Text(course.name),
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (Course? course) {
                                                      setState(() {
                                                        kursFrage = course!;
                                                      });
                                                    })
                                              ]),
                                          Spacer(),
                                          FloatingActionButton.extended(
                                              label: const Text("Erstellen"),
                                              onPressed: () {
                                                newThread();
                                              })
                                        ]))),
                              ),
                              //if (user.role != "Student")
                              //Umfragen
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                            width: 2.0,
                                            color: Theme.of(context)
                                                .highlightColor,
                                            style: BorderStyle.solid),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(children: [
                                            const Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text("Frage")),
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    controller:
                                                        _controllerUmfrage,
                                                    maxLines: 3, //or null
                                                    decoration:
                                                        const InputDecoration
                                                                .collapsed(
                                                            hintText:
                                                                "Bitte geben Sie hier Ihre Frage ein"),
                                                  )),
                                            ),
                                            for (var i = 0;
                                                i < answerControllers.length;
                                                i++)
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Antwort ${i + 1}"),
                                                    SizedBox(
                                                      width: 180,
                                                      child: TextField(
                                                        controller:
                                                            answerControllers[
                                                                i],
                                                        maxLines: 1, //or null
                                                        decoration:
                                                            const InputDecoration
                                                                    .collapsed(
                                                                hintText:
                                                                    "Fragemöglichkeit eingeben"),
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            answerControllers
                                                                .removeWhere(
                                                                    (item) =>
                                                                        item ==
                                                                        answerControllers[
                                                                            i]);
                                                          });
                                                        },
                                                        icon: Icon(Icons
                                                            .remove_circle_outline))
                                                  ]),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (answerControllers
                                                            .length <
                                                        5) {
                                                      answerControllers.add(
                                                          TextEditingController());
                                                    } else {
                                                      showInSnackbar(context,
                                                          "Maximal 5 Antwortmöglichkeiten");
                                                    }
                                                  });
                                                },
                                                icon: const Icon(
                                                    Icons.add_circle_outline)),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text("Kurs"),
                                                  DropdownButton(
                                                      value: kursUmfrage,
                                                      items: courses.map<
                                                              DropdownMenuItem<
                                                                  Course>>(
                                                          (Course course) {
                                                        return DropdownMenuItem<
                                                            Course>(
                                                          value: course,
                                                          child:
                                                              Text(course.name),
                                                        );
                                                      }).toList(),
                                                      onChanged:
                                                          (Course? course) {
                                                        setState(() {
                                                          kursUmfrage = course!;
                                                        });
                                                      })
                                                ]),
                                            Spacer(),
                                            FloatingActionButton.extended(
                                                label: const Text("Erstellen"),
                                                onPressed: () {
                                                  newSurvey();
                                                })
                                          ]))),
                                ),
                              ),
                            ]),
                          )
                        ]))
              ]));
  }

  void fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    jwt ??=
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2NjY4MDkzNTksImV4cCI6MTY2NjgyMzc1OX0.hPw63fzL_GP_hYpMwuaxpYbyxqSCtw4Su91s9ge51Qk";
    List<Course> initCourses = await httpHelper.getCourses(jwt);
    User initUser = await httpHelper.getUser(jwt);
    setState(() {
      courses = initCourses;
      user = initUser;
      fetching = false;
    });
  }

  void newThread() async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    jwt ??=
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2NjY4MDkzNTksImV4cCI6MTY2NjgyMzc1OX0.hPw63fzL_GP_hYpMwuaxpYbyxqSCtw4Su91s9ge51Qk";
    Thread thread =
        Thread("", kursFrage.getId, "", "", _controllerFrage.text, "");
    var success = await httpHelper.postThread(jwt, thread);
    print(success);
    if (success) {
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MeinLernenS(),
          ));
    }
  }

  void newSurvey() async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    jwt ??=
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2NjY4MDkzNTksImV4cCI6MTY2NjgyMzc1OX0.hPw63fzL_GP_hYpMwuaxpYbyxqSCtw4Su91s9ge51Qk";

    List<String> answerTypes = [];
    for (var controller in answerControllers) {
      answerTypes.add(controller.text);
    }
    Survey survey = Survey(
        "",
        _controllerUmfrage.text,
        "descr",
        kursUmfrage.getId,
        StringEnumAnswerType("string", answerTypes),
        user.getId,
        [],
        false,
        "");
    var success = await httpHelper.postSurvey(jwt, survey);
    if (success) {
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MeinLernenS(),
          ));
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
}
