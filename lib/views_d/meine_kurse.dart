import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/kurs/einKurs.dart';
import 'package:learning_analytics/widgtes/kurs/neuerKurs.dart';
import 'package:learning_analytics/widgtes/shared/bottom_menu.dart';
import '../data/user.dart';

class MeineKurseD extends StatefulWidget {
  const MeineKurseD({
    Key? key,
  }) : super(key: key);

  @override
  State<MeineKurseD> createState() => _MeineKurseDState();
}

class _MeineKurseDState extends State<MeineKurseD> {
  List<String> exampleList = <String>["WWI20SEA", "WWI19SEA"];
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(children: const [
        Positioned(
          child: SizedBox(
              height: 160,
              child: CustomAppBar(title: "Meine Kurse", backToPage: "")),
        ),
      ]),
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 40, 15, 5),
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            height: 70,
            child: Card(
              color: Theme.of(context).highlightColor,
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
                          text: "Neuen Kurs erstellen",
                          style: Theme.of(context).textTheme.titleMedium,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NeuerKurs()));
                            })),
                ),
              ),
            )),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                        text: exampleList[0],
                        style: Theme.of(context).textTheme.titleMedium,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EinKurs(
                                          kursname: exampleList[0],
                                        )));
                          })),
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                        text: exampleList[1],
                        style: Theme.of(context).textTheme.titleMedium,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EinKurs(
                                          kursname: exampleList[1],
                                        )));
                          })),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
