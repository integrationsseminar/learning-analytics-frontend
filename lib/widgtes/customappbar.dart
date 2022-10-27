import 'package:flutter/material.dart';
import 'package:learning_analytics/views_d/mein_lernen.dart';
import 'package:learning_analytics/views_d/mein_profil.dart';
import 'package:learning_analytics/views_d/meine_kurse.dart';

import 'package:learning_analytics/views_s/mein_lernen.dart';
import 'package:learning_analytics/views_s/mein_profil.dart';
import 'package:learning_analytics/views_s/mein_fortschritt.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.title, required this.backToPage})
      : super(
          key: key,
        );
  final String title;
  final String backToPage;

  @override
  Widget build(
    BuildContext context,
  ) {
    Size size = MediaQuery.of(context).size; //get the screen size

    return Scaffold(
        // ignore: unnecessary_new
        body: Stack(
      children: <Widget>[
        Positioned(
          top: 30.0,
          child: Container(
              width: size.width * 0.8,
              height: 110.0,
              decoration: const BoxDecoration(
                  color: Color(0xffE30613),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Row(children: <Widget>[
                Visibility(
                  visible: (backToPage != "") ? true : false,
                  child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                      iconSize: 32,
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => (getSide(backToPage))));
                      }),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
              ])),
        )
      ],
    ));
  }

  Widget getSide(String calledPage) {
    Widget goToSide;
    switch (calledPage) {
      case "MeinLernenD":
        {
          goToSide = MeinLernenD();
          break;
        }
      case "MeinProfilD":
        {
          goToSide = MeinProfilD();
          break;
        }
      case "MeineKurseD":
        {
          goToSide = MeineKurseD();
          break;
        }
      case "MeinFortschrittS":
        {
          goToSide = MeinFortschrittS();
          break;
        }
      case "MeinLernenS":
        {
          goToSide = MeinLernenS();
          break;
        }
      case "MeinProfilS":
        {
          goToSide = MeinProfilS();
          break;
        }
      default:
        {
          goToSide = MeinLernenS();
        }
    }
    return goToSide;
  }
}
