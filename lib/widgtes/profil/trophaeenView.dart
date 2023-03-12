import 'package:flutter/material.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/profil/eineTrophaeen.dart';
import '../../data/user.dart';

class TrophaeenWidget extends StatefulWidget {
  const TrophaeenWidget({Key? key}) : super(key: key);

  @override
  State<TrophaeenWidget> createState() => _TrophaeenWidgetState();
}

class _TrophaeenWidgetState extends State<TrophaeenWidget> {
  List<String> list = <String>["User anlegen", "User kaufen"];
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(children: const [
        Positioned(
          child: SizedBox(
              height: 160,
              child: CustomAppBar(
                title: "Meine Profil",
                backToPage: "MeinProfilS",
              )),
        ),
      ]),
      Padding(
          padding: const EdgeInsets.fromLTRB(48.0, 8, 8, 8),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 500,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Deine Trophäen",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const EineTrophaee(text: "User anlegen"),
                      const EineTrophaee(text: "User anlegen"),
                      const EineTrophaee(text: "User anlegen"),
                    ],
                  ),
                )),
          )),
    ]);
  }
}
