import 'package:flutter/material.dart';
import 'package:learning_analytics/widgtes/lernen/balkendiagramm.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../data/antwort.dart';

class Umfrage extends StatefulWidget {
  const Umfrage(
      {super.key,
      required this.frage,
      required this.tags,
      required this.answers,
      required this.seriesList});
  final String frage;
  final List<String> tags;
  final int answers;
  final List<charts.Series<AntwortClass, String>> seriesList;

  @override
  State<Umfrage> createState() => _UmfrageState();
}

class _UmfrageState extends State<Umfrage> {
  @override
  Widget build(BuildContext context) => Card(
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
                    child: Text(widget.frage,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
                SimpleBarChart(seriesList: widget.seriesList, animate: true)
              ],
            ),
            Card(
                color: Theme.of(context).secondaryHeaderColor,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(children: [
                  for (var tag in widget.tags)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context).highlightColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(tag),
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
                                child: Text(widget.answers.toString()))),
                      ),
                    ),
                  ),
                ])),
          ],
        ),
      );
}
