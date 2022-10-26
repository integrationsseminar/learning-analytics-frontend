import 'dart:html';

import 'package:flutter/material.dart';
import '../widgtes/lernen/antwort.dart';
import '../widgtes/customappbar.dart';
import '../data/antwort.dart';

class AddFrage extends StatefulWidget {
  const AddFrage({Key? key}) : super(key: key);

  @override
  State<AddFrage> createState() => _AddFrageState();
}

class _AddFrageState extends State<AddFrage> {
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
                  child: const CustomAppBar(
                      title: "Mein Lernen", backToPage: "MeinLernenS"))),
        ),
      ),
      Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
                width: 2.0,
                color: Theme.of(context).highlightColor,
                style: BorderStyle.solid),
          ),
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                const Align(
                    alignment: Alignment.bottomLeft, child: Text("Frage")),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Theme.of(context).secondaryHeaderColor,
                  child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        maxLines: 3, //or null
                        decoration: InputDecoration.collapsed(
                            hintText: "Bitte geben Sie hier Ihre Frage ein"),
                      )),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Tag"),
                      DropdownButton(items: [
                        const DropdownMenuItem(value: "Tag", child: Text("Tag"))
                      ], onChanged: (Object? value) {})
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Kurs"),
                      DropdownButton(items: [
                        const DropdownMenuItem(
                            value: "Kurs", child: Text("Kurs"))
                      ], onChanged: (Object? value) {})
                    ]),
                FloatingActionButton.extended(
                    label: const Text("Erstellen"), onPressed: () {})
              ])))
    ]));
  }
}
