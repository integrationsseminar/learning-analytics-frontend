import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../../data/antwort.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series<Antwort, String>> seriesList;
  final bool animate;

  const SimpleBarChart(
      {required this.seriesList, super.key, required this.animate});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: charts.BarChart(
        seriesList,
        animate: animate,
      ),
    );
  }
}
