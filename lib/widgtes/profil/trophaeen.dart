import 'package:flutter/material.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';

class Trophaeen extends StatelessWidget {
  const Trophaeen({Key? key}) : super(key: key);

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
                          Row(
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).highlightColor,
                                    shape: BoxShape.circle),
                                child: const Icon(Icons.emoji_events,
                                    color: Colors.white, size: 20),
                              ),
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                  child: Text("User angelegt"),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ])),
      ]),
    );
  }
}
