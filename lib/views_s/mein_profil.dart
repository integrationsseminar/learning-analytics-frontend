import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/profil/angaben.dart';
import 'package:learning_analytics/widgtes/profil/divider.dart';
import 'package:learning_analytics/widgtes/profil/trophaeen.dart';

class MeinProfilS extends StatefulWidget {
  const MeinProfilS({Key? key}) : super(key: key);

  @override
  State<MeinProfilS> createState() => _MeinProfilSState();
}

class _MeinProfilSState extends State<MeinProfilS> {
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
    Color? highlightColor = Theme.of(context).highlightColor;

    return Scaffold(
      body: Column(children: [
        Stack(children: const [
          Positioned(
            child: SizedBox(
                height: 160,
                child: CustomAppBar(title: "Mein Profil", backToPage: "")),
          ),
        ]),
        Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 381,
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
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "UserID",
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0.0, 0.0, 20.0, 0.0),
                                    child: Text(
                                      "25910",
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ]),
                            const DividerWidget(),
                            //----
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Username",
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                      width: 180,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 0.0, 20.0, 0.0),
                                          child: RichText(
                                            text: WidgetSpan(
                                              child: Text(
                                                "Loop",
                                                style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .splashColor,
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ]),
                            const DividerWidget(),
                            //------------------------------------------
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Hochschule",
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                      width: 180,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 0.0, 20.0, 0.0),
                                          child: RichText(
                                            text: WidgetSpan(
                                              child: Text(
                                                "DHBW Mannheim",
                                                style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .splashColor,
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ]),
                            const DividerWidget(),
                            //------------------------------------------
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Studiengang",
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                      width: 180,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 0.0, 20.0, 0.0),
                                          child: RichText(
                                            text: WidgetSpan(
                                              child: Text(
                                                "Bachelor Software Engineering",
                                                style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .splashColor,
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ]),
                            const DividerWidget(),
                            //------------------------------------------
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Semester",
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                      width: 180,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 0.0, 20.0, 0.0),
                                          child: RichText(
                                            text: WidgetSpan(
                                              child: Text(
                                                "4",
                                                style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .splashColor,
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ]),
                            const DividerWidget(),
                            //------------------------------------------
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Branche",
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                      width: 180,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 0.0, 20.0, 0.0),
                                          child: RichText(
                                            text: WidgetSpan(
                                              child: Text(
                                                "IT",
                                                style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .splashColor,
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ]),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 40.0, 8.0, 0.0),
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
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 70,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(
                          color: Theme.of(context).highlightColor,
                          style: BorderStyle.solid,
                          width: 3),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: RichText(
                            text: TextSpan(
                                text: "Deine Trophäen",
                                style: const TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Trophaeen()));
                                  })),
                      ),
                    ),
                  ),
                ),
              )
            ]))
      ]),
    );
  }
}
