import 'package:flutter/material.dart';
import 'package:learning_analytics/data/threadwithcomments.dart';
import '../widgtes/lernen/frage.dart';
import '../widgtes/lernen/umfrage.dart';
import '../data/course.dart';
import '../data/survey.dart';
import '../data/http_helper.dart';
import './add_fragen_view.dart';
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
                  padding: const EdgeInsets.all(8.0),
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
                  padding: const EdgeInsets.all(8.0),
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
                  padding: const EdgeInsets.all(8.0),
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
                      child: Text("Fragen",
                          style: Theme.of(context).textTheme.headlineSmall)),
                )
              ]),
              Expanded(
                child: ListView(children: [
                  Column(
                    children: [
                      const SizedBox(height: 15),
                      FloatingActionButton.extended(
                          icon: const Icon(Icons.add),
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AddFrage(),
                                ));
                          },
                          label: Text("Neuen Eintrag hinzufügen",
                              style: Theme.of(context).textTheme.titleSmall)),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(children: [
                          if (fragen)
                            for (var thread in threads)
                              if (dropdownValue.getId == "0" ||
                                  thread.thread.course == dropdownValue.getId)
                                Column(
                                  children: [
                                    Frage(
                                        threadwithcomments: thread,
                                        courseName: courses
                                            .firstWhere((course) =>
                                                course.getId ==
                                                thread.thread.course)
                                            .name),
                                    const SizedBox(height: 10)
                                  ],
                                ),
                          if (umfragen)
                            for (var survey in surveys)
                              if (dropdownValue.getId == "0" ||
                                  survey.course == dropdownValue.getId)
                                Column(
                                  children: [
                                    Umfrage(
                                        survey: survey,
                                        courseName: courses
                                            .firstWhere((course) =>
                                                course.getId == survey.course)
                                            .name),
                                    const SizedBox(height: 10)
                                  ],
                                )
                        ]),
                      ),
                    ],
                  ),
                ]),
              )
            ]),
      bottomNavigationBar: BottomMenu(index: 1),
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
    setState(() {
      courses.addAll(initCourses);
      threads = initThreads;
      surveys = initSurveys;
      fetching = false;
    });
  }
}
