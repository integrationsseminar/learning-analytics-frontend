import 'package:flutter/material.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/fortschritt/angaben.dart';
import 'package:learning_analytics/widgtes/shared/divider.dart';
import 'package:learning_analytics/widgtes/shared/bottom_menu.dart';
import '../data/user.dart';

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

  int tabsAmount = 2;

  @override
  Widget build(BuildContext context) {
    String dropdownValue = list.first;

    return Column(children: [
      Stack(children: const [
        Positioned(
          child: SizedBox(
              height: 160,
              child: CustomAppBar(
                  title: "Mein Fortschritt", backToPage: "MeinFortschrittS")),
        ),
      ]),
      Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          DefaultTabController(
              length: tabsAmount,
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (tabsAmount == 2)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                                width: 2.0,
                                color: Theme.of(context).highlightColor,
                                style: BorderStyle.solid),
                          ),
                          child: TabBar(
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).highlightColor),
                            labelColor: Theme.of(context).primaryColor,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Tab(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Tracker",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Statistik",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                      height: tabsAmount == 2 ? 410 : 470,
                      child: TabBarView(children: [
                        //Fragen
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
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 40.0, 8.0, 0.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            height: 32.0,
                                            minWidth: 120.0,
                                            color: Theme.of(context)
                                                .highlightColor,
                                            textColor: Colors.black,
                                            onPressed: () => {},
                                            splashColor: Colors.redAccent,
                                            child: const Text(
                                              "Speichern",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ), //Umfragen
                        if (tabsAmount == 2)
                          Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                    color: Theme.of(context).highlightColor,
                                    style: BorderStyle.solid,
                                    width: 3),
                              ),
                              child:
                                  const Center(child: Text("Noch in Arbeit."))),
                      ]),
                    )
                  ])),
        ]),
      ),
    ]);
  }
}
