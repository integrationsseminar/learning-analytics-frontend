import 'package:flutter/material.dart';
import '../widgtes/lernen/antwort.dart';
import '../widgtes/customappbar.dart';
import '../data/survey.dart';
import '../data/antwort.dart';
import 'package:flutter/material.dart';
import 'package:learning_analytics/widgtes/lernen/balkendiagramm.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class UmfragenView extends StatefulWidget {
  UmfragenView({Key? key, required this.survey, required this.courseName})
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
              child: Text(getDate(widget.survey.createdAt),
                  style: Theme.of(context).textTheme.bodySmall)),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(widget.survey.title,
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          SimpleBarChart(
              seriesList: createSeriesList(widget.survey), animate: true),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("Meine Antwort"),
            DropdownButton(
                value: dropdownValue,
                items: answers.map<DropdownMenuItem<String>>((String answer) {
                  return DropdownMenuItem<String>(
                    value: answer,
                    child: Text(answer),
                  );
                }).toList(),
                onChanged: (String? answer) {
                  setState(() {
                    dropdownValue = answer!;
                  });
                })
          ]),
          Spacer(),
          FloatingActionButton.extended(
              label: const Text("Antwort einreichen"),
              onPressed: () {
                newAnswer();
              })
        ]),
      ),
    ]));
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

  void newAnswer() async {}
}
