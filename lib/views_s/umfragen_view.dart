import 'package:flutter/material.dart';
import 'package:learning_analytics/data/http_helper.dart';
import '../widgtes/customappbar.dart';
import '../widgtes/shared/bottom_menu.dart';
import '../data/survey.dart';
import '../data/user.dart';
import '../data/antwort.dart';
import 'package:learning_analytics/widgtes/lernen/balkendiagramm.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';

class UmfragenView extends StatefulWidget {
  final User user;
  UmfragenView(
      {Key? key,
      required this.survey,
      required this.courseName,
      required this.user})
      : super(key: key);
  late Survey survey;
  final String courseName;

  @override
  State<UmfragenView> createState() => _UmfragenViewState();
}

class _UmfragenViewState extends State<UmfragenView> {
  late List<String> answers = widget.survey.answerType.answers;
  late String dropdownValue = answers.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(children: const [
            Positioned(
              child: SizedBox(
                  height: 140,
                  child: CustomAppBar(
                    title: "Mein Lernen",
                    backToPage: "MeinLernenS",
                    difColor: true,
                  )),
            ),
          ]),
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Theme.of(context).secondaryHeaderColor),
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(getDate(widget.survey.createdAt),
                      style: Theme.of(context).textTheme.bodySmall)),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(widget.survey.title,
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
              SimpleBarChart(
                  seriesList: createSeriesList(widget.survey), animate: true),
            ]),
          ),
          const Spacer(),
          Padding(
              padding: const EdgeInsets.all(15),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Theme.of(context).secondaryHeaderColor,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 8.0, 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Meine Antwort",
                                style: Theme.of(context).textTheme.titleMedium),
                            Container(
                                height: 35,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(5)),
                                child: DropdownButton(
                                    underline: const SizedBox(),
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                    icon: const Icon(
                                        Icons.arrow_drop_down_rounded),
                                    iconSize: 25,
                                    dropdownColor:
                                        Theme.of(context).backgroundColor,
                                    borderRadius: BorderRadius.circular(5),
                                    value: dropdownValue,
                                    items: answers
                                        .map<DropdownMenuItem<String>>(
                                            (String answer) {
                                      return DropdownMenuItem<String>(
                                        value: answer,
                                        child: Text(answer),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                    }))
                          ]),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FloatingActionButton.extended(
                              label: Text("Antwort einreichen",
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              onPressed: () {
                                newAnswer();
                              }),
                        ),
                      ],
                    ),
                  ]))),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  static List<charts.Series<AntwortClass, String>> createSeriesList(
      Survey survey) {
    List<String> answerTypes = survey.answerType.answers;
    List<AntwortClass> data = [];
    for (var types in answerTypes) {
      var countSameAnswers = 0;
      for (var ans in survey.answers) {
        if (ans.answer == types) {
          countSameAnswers++;
        }
      }
      data.add(AntwortClass(types, countSameAnswers));
    }

    return [
      charts.Series<AntwortClass, String>(
        id: 'Antwort',
        colorFn: (_, __) => charts.MaterialPalette.gray.shadeDefault,
        domainFn: (AntwortClass antwort, _) => antwort.text,
        measureFn: (AntwortClass antwort, _) => antwort.anzahl,
        data: data,
      )
    ];
  }

  String getDate(String date) {
    DateTime dateLong = DateTime.parse(date);
    DateTime dateShort = DateTime(dateLong.year, dateLong.month, dateLong.day);
    return dateShort.toString().replaceAll("00:00:00.000", "");
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

  void newAnswer() async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    jwt ??=
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2NjY4MDkzNTksImV4cCI6MTY2NjgyMzc1OX0.hPw63fzL_GP_hYpMwuaxpYbyxqSCtw4Su91s9ge51Qk";
    var response = await HttpHelper()
        .submitAnswer(jwt, dropdownValue, widget.survey.getId);
    if (response) {
      Survey reloadedSurvey =
          await HttpHelper().getSurvey(jwt, widget.survey.getId);
      setState(() {
        widget.survey = reloadedSurvey;
      });
    } else {
      showInSnackbar(context, "Sie haben diese Umfrage bereits beantwortet.");
    }
  }
}
