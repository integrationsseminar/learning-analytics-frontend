import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:learning_analytics/data/course.dart';
import 'package:learning_analytics/data/http_helper.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/kurs/einKurs.dart';
import 'package:learning_analytics/widgtes/kurs/neuerKurs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learning_analytics/widgtes/shared/bottom_menu.dart';
import '../data/user.dart';

class MeineKurseD extends StatefulWidget {
  const MeineKurseD({
    Key? key,
  }) : super(key: key);

  @override
  State<MeineKurseD> createState() => _MeineKurseDState();
}

class _MeineKurseDState extends State<MeineKurseD> {
  late List<Course> courseList = [];
  late HttpHelper httpHelper;
  bool fetching = true;

  @override
  initState() {
    fetchingData();
    httpHelper = HttpHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return fetching
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(children: [
              Stack(children: const [
                Positioned(
                  child: SizedBox(
                      height: 140,
                      child:
                          CustomAppBar(title: "Meine Kurse", backToPage: "")),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 70,
                    child: Card(
                      color: Theme.of(context).highlightColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(
                            color: Theme.of(context).highlightColor,
                            style: BorderStyle.solid,
                            width: 3),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: RichText(
                              text: TextSpan(
                                  text: "Neuen Kurs erstellen",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NeuerKurs()));
                                    })),
                        ),
                      ),
                    )),
              ),
              for (var course in courseList)
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 70,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(
                            color: Theme.of(context).highlightColor,
                            style: BorderStyle.solid,
                            width: 3),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: RichText(
                              text: TextSpan(
                                  text: course.name,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EinKurs(
                                                    course: course,
                                                  )));
                                    })),
                        ),
                      ),
                    ),
                  ),
                ),
            ]),
          );
  }

  void fetchingData() async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    jwt ??=
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2Nzg5NzE5NjcsImV4cCI6MTY3ODk4NjM2N30.2pbQvew6C4zTYXzNtESahrI895yfoxIxofjENXpMVJg";
    List<Course> resultCourses = await httpHelper.getCourses(jwt);

    setState(() {
      courseList = resultCourses;
      fetching = false;
    });
  }
}
