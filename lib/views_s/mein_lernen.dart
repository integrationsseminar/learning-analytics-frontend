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
        const Positioned(
          child: SizedBox(
              height: 140,
              child: CustomAppBar(
                  title: "Mein Lernen", backToPage: "MeinLernenD")),
        ),
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
        Expanded(
          child: ListView(children: [
            Column(
              children: [
                FloatingActionButton.extended(
                    icon: Icon(Icons.add),
                    onPressed: () {},
                    label: const Text("Neuen Eintrag hinzufügen")),
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
                    ),
                    Frage(
                        frage:
                            "Könnten Sie die Lösungen für Aufgabe vier zur Verfügung stellen?",
                        tags: const ["Integrationsseminar", "Frage"],
                        answers: 1),
                  ]),
                ),
              ],
            ),
          ]),
        )
      ]),
    );
  }

  static List<charts.Series<AntwortClass, String>> createSeriesList() {
    final data = [
      AntwortClass('ja schon', 5),
      AntwortClass('eher nicht', 9),
      AntwortClass('bisschen', 6),
    ];

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
