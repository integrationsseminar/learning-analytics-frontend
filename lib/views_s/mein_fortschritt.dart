import 'package:flutter/material.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/profil/angaben.dart';
import 'package:learning_analytics/widgtes/profil/divider.dart';

class MeinFortschrittS extends StatefulWidget {
  const MeinFortschrittS({Key? key}) : super(key: key);

  @override
  State<MeinFortschrittS> createState() => _MeinFortschrittSState();
}

class _MeinFortschrittSState extends State<MeinFortschrittS> {
  List<String> list = <String>[
    'Sehr hoch',
    'Hoch',
    'Mittel',
    'Gering',
    'Sehr gering'
  ];

  @override
  Widget build(BuildContext context) {
    String dropdownValue = list.first;

    return Scaffold(
        body: Column(children: [
      Stack(children: const [
        Positioned(
          child: SizedBox(
              height: 160,
              child: CustomAppBar(title: "Mein Fortschritt", backToPage: "")),
        ),
      ]),
      Padding(
        padding: const EdgeInsets.only(top: 35.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 323,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                        color: Theme.of(context).highlightColor,
                        style: BorderStyle.solid,
                        width: 3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Angaben(text: "Lernmotivation"),
                        const DividerWidget(),
                        //----
                        const Angaben(text: "Lernaufwand"),
                        const DividerWidget(),
                        //------------------------------------------
                        const Angaben(text: "Lernerfolg"),
                        const DividerWidget(),
                        //------------------------------------------
                        const Angaben(text: "Stresslevel"),
                        const DividerWidget(),
                        //------------------------------------------
                        const Angaben(text: "Hochschulbindung"),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 0.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              height: 32.0,
                              minWidth: 120.0,
                              color: Theme.of(context).highlightColor,
                              textColor: Colors.black,
                              onPressed: () => {},
                              splashColor: Colors.redAccent,
                              child: const Text(
                                "Speichern",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ]),
      ),
    ]));
  }
}
