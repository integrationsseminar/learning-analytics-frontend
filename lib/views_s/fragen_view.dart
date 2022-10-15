import 'package:flutter/material.dart';
import '../widgtes/lernen/antwort.dart';
import '../widgtes/customappbar.dart';
import '../data/antwort.dart';

class FragenView extends StatefulWidget {
  const FragenView({Key? key}) : super(key: key);

  @override
  State<FragenView> createState() => _FragenViewState();
}

class _FragenViewState extends State<FragenView> {
  bool umfragen = true;

  bool fragen = true;

  List<AntwortClass> antworten = [
    AntwortClass("ja das wäre sehr wichtig", 0),
    AntwortClass("ja das wäre sehr wichtig", 1),
  ];

  List<String> tags = ["Integrationsseminar", "Frage"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Positioned(
        child: Container(
          child: SizedBox(
              height: 140,
              child: Container(
                  color: Theme.of(context).secondaryHeaderColor,
                  child: CustomAppBar(
                      title: "Mein Lernen", backToPage: "MeinLernenS"))),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            color: Theme.of(context).secondaryHeaderColor),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
                "Könnten Sie die Lösungen für Aufgabe vier zur Verfügung stellen?",
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          Row(children: [
            for (var tag in tags)
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).highlightColor),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(tag),
                    )),
              )
          ]),
        ]),
      ),
      Expanded(
        child: ListView(children: [
          Column(children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                Antwort(answer: "Ja das wäre super", type: "s"),
                Antwort(answer: "Ja kann ich machen", type: "d"),
                Antwort(answer: "Vielen Dank, das hat geholfen", type: "s")
              ]),
            ),
            FloatingActionButton.extended(
                icon: Icon(Icons.add),
                onPressed: () {},
                label: const Text("Neue Nachricht")),
          ]),
        ]),
      )
    ]));
  }
}
