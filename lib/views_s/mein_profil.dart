import 'package:flutter/material.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';

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

    return Scaffold(
        body: Column(children: [
      Stack(children: const [
        Positioned(
          child: SizedBox(
              height: 160,
              child: CustomAppBar(title: "Mein Profil", backToPage: "")),
        ),
      ]),
      Row(children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                    width: 200.0,
                    color: Theme.of(context).highlightColor,
                    style: BorderStyle.solid),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(children: [
                      Text(
                        "Lernmotivation",
                        style: TextStyle(fontFamily: 'Raleway', fontSize: 20),
                      ),
                      DropdownButton(
                          value: dropdownValue,
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          }),
                    ])
                  ],
                ),
              ),
            )),
      ]),
    ]));
  }
}
