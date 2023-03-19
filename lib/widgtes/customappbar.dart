import 'package:flutter/material.dart';
import '../app.dart';
import '../data/user.dart';
import 'package:learning_analytics/views_d/mein_profil.dart';
import 'package:learning_analytics/views_d/meine_kurse.dart';

import 'package:learning_analytics/views_s/mein_lernen.dart';
import 'package:learning_analytics/views_s/mein_profil.dart';
import 'package:learning_analytics/views_s/mein_fortschritt.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {Key? key,
      required this.title,
      required this.backToPage,
      this.difColor = false})
      : super(
          key: key,
        );
  final String title;
  final String backToPage;
  final bool difColor;

  @override
  Widget build(
    BuildContext context,
  ) {
    Size size = MediaQuery.of(context).size; //get the screen size

    return Scaffold(
        backgroundColor: difColor
            ? Theme.of(context).secondaryHeaderColor
            : Colors.transparent,
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
                          onPressed: () {
                            Navigator.pop(context);
                            /*await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        (getSide(backToPage))));*/
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
    print(calledPage);
    switch (calledPage) {
      case "MeinProfilD":
        {
          goToSide = App(currentIndex: 0);
          break;
        }
      case "MeineKurseD":
        {
          goToSide = App(currentIndex: 2);
          break;
        }
      case "MeinFortschrittS":
        {
          goToSide = App(currentIndex: 2);
          break;
        }
      case "MeinLernenS":
        {
          goToSide = App(currentIndex: 1);
          break;
        }
      case "MeinProfilS":
        {
          goToSide = App(currentIndex: 0);
          break;
        }
      default:
        {
          goToSide = App(currentIndex: 1);
        }
    }
    return goToSide;
  }
}
