import 'package:flutter/material.dart';
import 'package:learning_analytics/data/threadwithcomments.dart';
import '../widgtes/lernen/frage.dart';
import '../widgtes/lernen/umfrage.dart';
import '../data/course.dart';
import '../data/survey.dart';
import '../data/user.dart';
import '../data/http_helper.dart';
import './add_fragen_view.dart';
import './add_fragen_template_view.dart';
import '../widgtes/customappbar.dart';
import '../widgtes/shared/bottom_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeinLernenS extends StatefulWidget {
  const MeinLernenS({Key? key}) : super(key: key);

  @override
  State<MeinLernenS> createState() => _MeinLernenSState();
}

class _MeinLernenSState extends State<MeinLernenS> {
  bool umfragen = true;
  bool fragen = true;
  int counter = 0;
  late User user;

  List<Course> courses = [
    Course("0", "Alle Kurse", "", "", "", "", false),
  ];
  late Course dropdownValue = courses.first;
  List<Threadwithcomments> threads = [];
  List<Survey> surveys = [];

  late HttpHelper httpHelper;
  bool fetching = true;

  @override
  initState() {
    httpHelper = HttpHelper();
    fetchData();
    super.initState();
  }

  var selectedItem = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: fetching
          ? const Center(child: CircularProgressIndicator())
          : Column(children: [
              Stack(
                children: const [
                  Positioned(
                    child: SizedBox(
                        height: 140,
                        child:
                            CustomAppBar(title: "Mein Lernen", backToPage: "")),
                  )
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(4.0, 8, 0, 8),
                  child: Container(
                    height: 28,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton(
                        underline: SizedBox(),
                        style: Theme.of(context).textTheme.headlineSmall,
                        icon: const Icon(Icons.arrow_drop_down_rounded,
                            color: Colors.white),
                        iconSize: 15,
                        dropdownColor: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(5),
                        value: dropdownValue,
                        items: courses
                            .map<DropdownMenuItem<Course>>((Course course) {
                          return DropdownMenuItem<Course>(
                            value: course,
                            child: Text(course.name,
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                          );
                        }).toList(),
                        onChanged: (Course? course) {
                          setState(() {
                            dropdownValue = course!;
                          });
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 8),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          umfragen = !umfragen;
                        });
                      },
                      style: umfragen
                          ? Theme.of(context).elevatedButtonTheme.style
                          : ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xffD9D9D9))),
                      child: Text("Umfragen",
                          style: Theme.of(context).textTheme.headlineSmall)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 8),
                  child: ElevatedButton(
                      style: fragen
                          ? Theme.of(context).elevatedButtonTheme.style
                          : ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xffD9D9D9))),
                      onPressed: () {
                        setState(() {
                          fragen = !fragen;
                        });
                      },
                      child: Text("Unterhaltung",
                          style: Theme.of(context).textTheme.headlineSmall)),
                )
              ]),
              Container(
                height: MediaQuery.of(context).size.height - 234,
                child: ListView(children: [
                  Column(
                    children: [
                      const SizedBox(height: 15),
                      FloatingActionButton.extended(
                          icon: PopupMenuButton(
                              icon: const Icon(Icons.arrow_drop_down_outlined),
                              onSelected: (bool value) async {
                                setState(() {
                                  selectedItem = value;
                                });
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => selectedItem
                                          ? AddFrage(user: user)
                                          : AddFrageTemplate(user: user),
                                    ));
                              },
                              itemBuilder: (BuildContext bc) {
                                return [
                                  PopupMenuItem(
                                    value: false,
                                    child: Text("Eintrag mit Vorlage erstellen",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                  ),
                                  PopupMenuItem(
                                    value: true,
                                    child: Text(
                                        "Eintrag ohne Vorlage erstellen",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                  )
                                ];
                              }),
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddFrage(user: user),
                                ));
                          },
                          label: Text("Neuen Eintrag hinzufügen",
                              style: Theme.of(context).textTheme.titleSmall)),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                            children: getLearningWidgets(threads, surveys)),
                      ),
                    ],
                  ),
                ]),
              ),
            ]),
    );
  }

  void fetchData() async {
    courses = [
      Course("0", "Alle Kurse", "", "", "", "", false),
    ];
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    jwt ??=
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2NjY4MDkzNTksImV4cCI6MTY2NjgyMzc1OX0.hPw63fzL_GP_hYpMwuaxpYbyxqSCtw4Su91s9ge51Qk";
    List<Threadwithcomments> initThreads =
        await httpHelper.getThreadswithcomments(jwt);
    List<Survey> initSurveys = await httpHelper.getSurveys(jwt);
    List<Course> initCourses = await httpHelper.getCourses(jwt);
    User initUser = await httpHelper.getUser(jwt);
    setState(() {
      courses.addAll(initCourses);
      user = initUser;
      threads = initThreads;
      surveys = initSurveys;
      fetching = false;
    });
  }

  List<Widget> getLearningWidgets(threads, surveys) {
    int counter = 0;
    int threadCounter = 0;
    List<Widget> learningThreads = [];
    while (fragen && threadCounter < threads.length) {
      Threadwithcomments thread = threads[threadCounter];
      if (counter == surveys.length ||
          DateTime.parse(thread.thread.createdAt)
              .isAfter(DateTime.parse(surveys[counter].createdAt))) {
        if ((dropdownValue.getId == "0" ||
                thread.thread.course == dropdownValue.getId) &&
            (courses.any((course) => course.getId == thread.thread.course))) {
          learningThreads.add(Column(
            children: [
              Frage(
                  user: user,
                  threadwithcomments: thread,
                  courseName: courses
                      .firstWhere(
                          (course) => course.getId == thread.thread.course)
                      .name),
              const SizedBox(height: 10)
            ],
          ));
        }
        threadCounter++;
      } else if (umfragen) {
        Survey survey = surveys[counter];
        if ((dropdownValue.getId == "0" ||
                survey.course == dropdownValue.getId) &&
            (courses.any((course) => course.getId == survey.course))) {
          learningThreads.add(Column(
            children: [
              Umfrage(
                  user: user,
                  survey: survey,
                  courseName: courses
                      .firstWhere((course) => course.getId == survey.course)
                      .name),
              const SizedBox(height: 10)
            ],
          ));
        }
        counter++;
      }
    }
    while (counter < surveys.length && umfragen) {
      Survey survey = surveys[counter];
      if ((dropdownValue.getId == "0" ||
              survey.course == dropdownValue.getId) &&
          (courses.any((course) => course.getId == survey.course))) {
        learningThreads.add(Column(
          children: [
            Umfrage(
                user: user,
                survey: survey,
                courseName: courses
                    .firstWhere((course) => course.getId == survey.course)
                    .name),
            const SizedBox(height: 10)
          ],
        ));
      }
      counter++;
    }
    return learningThreads;
  }
}
