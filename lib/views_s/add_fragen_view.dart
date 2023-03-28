import 'package:flutter/material.dart';
import 'package:learning_analytics/data/stringEnumAnswerType.dart';
import 'package:learning_analytics/views_s/mein_lernen.dart';
import '../app.dart';
import '../widgtes/customappbar.dart';
import '../widgtes/shared/divider.dart';
import '../widgtes/shared/bottom_menu.dart';
import '../data/thread.dart';
import '../data/user.dart';
import '../data/course.dart';
import '../data/survey.dart';
import '../data/http_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFrage extends StatefulWidget {
  final int initialIndex;
  final String initialText;
  final User user;
  const AddFrage(
      {Key? key,
      this.initialIndex = 0,
      this.initialText = "",
      required this.user})
      : super(key: key);

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
  late int tabsAmount = (widget.user.role == "Student" ? 1 : 2);
  bool fetching = true;
  late List<TextEditingController> answerControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void initState() {
    super.initState();
    _controllerFrage = TextEditingController();
    _controllerUmfrage = TextEditingController();
    if (widget.initialIndex == 1) {
      _controllerUmfrage.value = TextEditingValue(
        text: widget.initialText,
        selection: TextSelection.fromPosition(
          TextPosition(offset: widget.initialText.length),
        ),
      );
    } else {
      _controllerFrage.value = TextEditingValue(
        text: widget.initialText,
        selection: TextSelection.fromPosition(
          TextPosition(offset: widget.initialText.length),
        ),
      );
    }
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
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Stack(children: [
            Positioned(
              child: SizedBox(
                  height: 160,
                  child: CustomAppBar(
                    title: "Mein Lernen",
                    backToPage: "MeinLernenS",
                  )),
            ),
          ]),
          fetching
              ? const Center(child: CircularProgressIndicator())
              : DefaultTabController(
                  length: tabsAmount,
                  initialIndex: widget.initialIndex,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        if (tabsAmount == 2)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                    width: 2.0,
                                    color: Theme.of(context).highlightColor,
                                    style: BorderStyle.solid),
                              ),
                              child: TabBar(
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Theme.of(context).highlightColor),
                                labelColor: Theme.of(context).primaryColor,
                                unselectedLabelColor: Colors.black,
                                tabs: [
                                  Tab(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Unterhaltung",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium),
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Umfrage",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 185,
                          child: TabBarView(children: [
                            //Fragen
                            SizedBox(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
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
                                            Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 13.0),
                                                  child: Text("Unterhaltung",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall),
                                                )),
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor,
                                              child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: TextField(
                                                    controller:
                                                        _controllerFrage,
                                                    maxLines: 6,
                                                    decoration:
                                                        const InputDecoration
                                                                .collapsed(
                                                            hintText:
                                                                "Unterhaltung eingeben"),
                                                  )),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 13.0),
                                                    child: Text("Kurs",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall),
                                                  ),
                                                  Container(
                                                      height: 28,
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 5),
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  5)),
                                                      child: DropdownButton(
                                                          underline:
                                                              const SizedBox(),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .labelSmall,
                                                          icon: const Icon(Icons
                                                              .arrow_drop_down_rounded),
                                                          iconSize: 15,
                                                          dropdownColor:
                                                              Theme.of(context)
                                                                  .backgroundColor,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  5),
                                                          value: kursFrage,
                                                          items: courses.map<
                                                                  DropdownMenuItem<Course>>(
                                                              (Course course) {
                                                            return DropdownMenuItem<
                                                                Course>(
                                                              value: course,
                                                              child: Text(
                                                                  course.name),
                                                            );
                                                          }).toList(),
                                                          onChanged:
                                                              (Course? course) {
                                                            setState(() {
                                                              kursFrage =
                                                                  course!;
                                                            });
                                                          }))
                                                ]),
                                            Spacer(),
                                            FloatingActionButton.extended(
                                                label: Text("Erstellen",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium),
                                                onPressed: () {
                                                  newThread();
                                                })
                                          ]))),
                                ),
                              ),
                            ),
                            //Umfragen
                            if (tabsAmount == 2)
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
                                          Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 13.0),
                                                child: Text("Umfrage",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall),
                                              )),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            color: Theme.of(context)
                                                .secondaryHeaderColor,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: TextField(
                                                  controller:
                                                      _controllerUmfrage,
                                                  maxLines: 3, //or null
                                                  decoration:
                                                      const InputDecoration
                                                              .collapsed(
                                                          hintText:
                                                              "Umfrage eingeben"),
                                                )),
                                          ),
                                          for (var i = 0;
                                              i < answerControllers.length;
                                              i++)
                                            Column(
                                              children: [
                                                SizedBox(height: 10),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 13.0),
                                                        child: Text(
                                                            "Antwort ${i + 1}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 13.0),
                                                        child: SizedBox(
                                                          width: 220,
                                                          child: TextField(
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelSmall,
                                                            controller:
                                                                answerControllers[
                                                                    i],
                                                            maxLines:
                                                                1, //or null
                                                            decoration:
                                                                const InputDecoration
                                                                        .collapsed(
                                                                    hintText:
                                                                        "Antwortmöglichkeit"),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                              ],
                                            ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (answerControllers
                                                              .length <
                                                          6) {
                                                        answerControllers.add(
                                                            TextEditingController());
                                                      } else {
                                                        showInSnackbar(context,
                                                            "Maximal sechs Antwortmöglichkeiten");
                                                      }
                                                    });
                                                  },
                                                  icon: const Icon(
                                                      Icons.add_circle_outline,
                                                      color: Colors.black)),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (answerControllers
                                                              .length >
                                                          2) {
                                                        answerControllers
                                                            .removeLast();
                                                      } else {
                                                        showInSnackbar(context,
                                                            "Eine Umfrage braucht mindestens zwei Antwortmöglichkeiten");
                                                      }
                                                    });
                                                  },
                                                  icon: const Icon(
                                                      Icons
                                                          .remove_circle_outline,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                          DividerWidget(),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 13.0),
                                                  child: Text("Kurs",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall),
                                                ),
                                                Container(
                                                    height: 28,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 5),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5)),
                                                    child: DropdownButton(
                                                        underline:
                                                            const SizedBox(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall,
                                                        icon: const Icon(Icons
                                                            .arrow_drop_down_rounded),
                                                        iconSize: 15,
                                                        dropdownColor:
                                                            Theme.of(context)
                                                                .backgroundColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                        value: kursUmfrage,
                                                        items: courses
                                                            .map<DropdownMenuItem<Course>>(
                                                                (Course
                                                                    course) {
                                                          return DropdownMenuItem<
                                                              Course>(
                                                            value: course,
                                                            child: Text(
                                                                course.name),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (Course? course) {
                                                          setState(() {
                                                            kursUmfrage =
                                                                course!;
                                                          });
                                                        }))
                                              ]),
                                          Spacer(),
                                          FloatingActionButton.extended(
                                              label: Text("Erstellen",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium),
                                              onPressed: () {
                                                newSurvey();
                                              })
                                        ]))),
                              ),
                          ]),
                        )
                      ]))
        ]),
      ),
    );
  }

  void fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    jwt ??=
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2NjY4MDkzNTksImV4cCI6MTY2NjgyMzc1OX0.hPw63fzL_GP_hYpMwuaxpYbyxqSCtw4Su91s9ge51Qk";
    List<Course> initCourses = await httpHelper.getCourses(jwt);
    setState(() {
      courses = initCourses;
      fetching = false;
    });
  }

  void newThread() async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    jwt ??=
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2NjY4MDkzNTksImV4cCI6MTY2NjgyMzc1OX0.hPw63fzL_GP_hYpMwuaxpYbyxqSCtw4Su91s9ge51Qk";
    if (_controllerFrage.text == "") {
      showInSnackbar(context, "Bitte Text für Unterhaltung eingeben.");
    } else {
      Thread thread =
          Thread("", kursFrage.getId, "", "", _controllerFrage.text, "");
      var success = await httpHelper.postThread(jwt, thread);
      print(success);
      if (success) {
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => App(currentIndex: 1),
            ));
      }
    }
  }

  void newSurvey() async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    jwt ??=
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2NjY4MDkzNTksImV4cCI6MTY2NjgyMzc1OX0.hPw63fzL_GP_hYpMwuaxpYbyxqSCtw4Su91s9ge51Qk";
    List<String> answerTypes = [];
    var postSurvey = true;
    if (_controllerUmfrage.text == "") {
      showInSnackbar(context, "Bitte Text für Umfrage eingeben.");
      postSurvey = false;
    } else {
      for (var controller in answerControllers) {
        if (controller.text == "") {
          showInSnackbar(context, "Bitte alle Antworten füllen.");
          postSurvey = false;
        }
        answerTypes.add(controller.text);
      }
    }
    if (postSurvey) {
      List checkDuplicates = [];
      answerTypes.forEach((u) {
        if (checkDuplicates.contains(u)) {
          postSurvey = false;
          showInSnackbar(context,
              "$u ist ein Duplikat. Es können keine Umfragen mit identischen Antworten erstellt werden.");
        } else {
          checkDuplicates.add(u);
        }
      });
    }
    if (postSurvey) {
      Survey survey = Survey(
          "",
          _controllerUmfrage.text,
          "descr",
          kursUmfrage.getId,
          StringEnumAnswerType("string", answerTypes),
          widget.user.getId,
          [],
          false,
          "");
      var success = await httpHelper.postSurvey(jwt, survey);
      if (success) {
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => App(currentIndex: 1),
            ));
      }
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
