import 'package:flutter/material.dart';
import '../widgtes/lernen/antwort.dart';
import '../widgtes/customappbar.dart';
import '../data/antwort.dart';
import '../data/threadwithcomments.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FragenView extends StatefulWidget {
  const FragenView({Key? key, required this.threadwithcomments})
      : super(key: key);
  final Threadwithcomments threadwithcomments;

  @override
  State<FragenView> createState() => _FragenViewState();
}

class _FragenViewState extends State<FragenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Positioned(
        child: SizedBox(
            height: 140,
            child: Container(
                color: Theme.of(context).secondaryHeaderColor,
                child: const CustomAppBar(
                    title: "Mein Lernen", backToPage: "MeinLernenS"))),
      ),
      Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            color: Theme.of(context).secondaryHeaderColor),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(widget.threadwithcomments.thread.title,
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          Row(children: [
            for (var tag in widget.threadwithcomments.thread.tags)
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).highlightColor),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(tag),
                    )),
              )
          ]),
        ]),
      ),
      Expanded(
        child: ListView(children: [
          Column(children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                for (var antwort in widget.threadwithcomments.threadcomments)
                  Antwort(answer: antwort.message, type: antwort.type),
              ]),
            ),
            FloatingActionButton.extended(
                icon: Icon(Icons.add),
                onPressed: () {
                  newMessage();
                },
                label: const Text("Neue Nachricht")),
          ]),
        ]),
      )
    ]));
  }

  void newMessage() async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    jwt ??= "634dad62663403c8063adc41";
  }
}
