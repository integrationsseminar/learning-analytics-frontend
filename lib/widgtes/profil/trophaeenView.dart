import 'package:flutter/material.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/profil/eineTrophaeen.dart';

class TrophaeenWidget extends StatefulWidget {
  const TrophaeenWidget({Key? key}) : super(key: key);

  @override
  State<TrophaeenWidget> createState() => _TrophaeenWidgetState();
}

class _TrophaeenWidgetState extends State<TrophaeenWidget> {
  List<String> list = <String>["User anlegen", "User kaufen"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Stack(children: const [
          Positioned(
            child: SizedBox(
                height: 160,
                child: CustomAppBar(
                    title: "Meine Profil", backToPage: "MeinProfilS")),
          ),
        ]),
        Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 150,
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
                                  children: const [
                                    Center(
                                      child: Text(
                                        "Deine Trophäen",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Expanded(
                                    child: EineTrophaee(text: "User anlegen")),
                              ],
                            ),
                          )),
                    ),
                  ),
                ])),
      ]),
    );
  }
}
