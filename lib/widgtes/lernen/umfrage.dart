import 'package:flutter/material.dart';
import 'package:learning_analytics/widgtes/lernen/balkendiagramm.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../data/antwort.dart';
import '../../data/survey.dart';
import '../../views_s/umfragen_view.dart';
import '../../data/user.dart';

class Umfrage extends StatefulWidget {
  final User user;
  const Umfrage(
      {super.key,
      required this.survey,
      required this.courseName,
      required this.user});
  final Survey survey;
  final String courseName;

  @override
  State<Umfrage> createState() => _UmfrageState();
}

class _UmfrageState extends State<Umfrage> {
  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UmfragenView(
                user: widget.user,
                survey: widget.survey,
                courseName: widget.courseName,
              ),
            ));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
              width: 2.0,
              color: Theme.of(context).highlightColor,
              style: BorderStyle.solid),
        ),
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                        textAlign: TextAlign.center,
                        widget.survey.title,
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                ),
                SimpleBarChart(
                    seriesList: createSeriesList(widget.survey), animate: true)
              ],
            ),
            Card(
                color: Theme.of(context).secondaryHeaderColor,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(children: [
                  for (var tag in [widget.courseName, "Umfrage"])
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context).highlightColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(tag,
                                style: Theme.of(context).textTheme.titleSmall),
                          )),
                    ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context).highlightColor),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 15,
                                  child: Text(
                                      textAlign: TextAlign.center,
                                      widget.survey.answers.length.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                ))),
                      ),
                    ),
                  ),
                ])),
          ],
        ),
      ));

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
}
