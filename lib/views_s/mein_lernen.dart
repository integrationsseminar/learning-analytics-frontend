import 'package:flutter/material.dart';
import '../widgtes/lernen/frage.dart';
import '../widgtes/lernen/umfrage.dart';
import '../data/antwort.dart';
import './fragen_view.dart';
import '../widgtes/customappbar.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MeinLernenS extends StatefulWidget {
  const MeinLernenS({Key? key}) : super(key: key);

  @override
  State<MeinLernenS> createState() => _MeinLernenSState();
}

class _MeinLernenSState extends State<MeinLernenS> {
  bool umfragen = true;

  bool fragen = true;

  List<String> list = <String>[
    'Alle Kurse',
    'Integrationsseminar',
    'Statistik',
    'Marketing'
  ];

  @override
  Widget build(BuildContext context) {
    String dropdownValue = list.first;

    return Scaffold(
      body: Column(children: [
        Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
                value: dropdownValue,
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                }),
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
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffD9D9D9))),
                child: const Text("Umfragen")),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: fragen
                    ? Theme.of(context).elevatedButtonTheme.style
                    : ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffD9D9D9))),
                onPressed: () {
                  setState(() {
                    fragen = !fragen;
                  });
                },
                child: const Text("Fragen")),
          )
        ]),
        FloatingActionButton.extended(
            onPressed: () {}, label: const Text("Neuen Eintrag hinzufügen")),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Frage(
                frage:
                    "Könnten Sie die Lösungen für Aufgabe vier zur Verfügung stellen?",
                tags: const ["Integrationsseminar", "Frage"],
                answers: 1),
            Umfrage(
              frage:
                  "Könnten Sie die Lösungen für Aufgabe vier zur Verfügung stellen?",
              tags: const ["Integrationsseminar", "Umfrage"],
              answers: 15,
              seriesList: createSeriesList(),
            )
          ]),
        )
      ]),
    );
  }

  static List<charts.Series<Antwort, String>> createSeriesList() {
    final data = [
      Antwort('ja schon', 5),
      Antwort('eher nicht', 9),
      Antwort('bisschen', 6),
    ];

    return [
      charts.Series<Antwort, String>(
        id: 'Antwort',
        colorFn: (_, __) => charts.MaterialPalette.gray.shadeDefault,
        domainFn: (Antwort antwort, _) => antwort.text,
        measureFn: (Antwort antwort, _) => antwort.anzahl,
        data: data,
      )
    ];
  }
}
