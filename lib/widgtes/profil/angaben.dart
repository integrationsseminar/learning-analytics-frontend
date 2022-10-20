import 'package:flutter/material.dart';

class Angaben extends StatefulWidget {
  final String text;

  const Angaben({Key? key, required this.text});

  @override
  State<Angaben> createState() => _AngabenState();
}

class _AngabenState extends State<Angaben> {
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

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        widget.text,
        style: const TextStyle(
            fontFamily: 'Raleway', fontSize: 13, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 15,
        child: DropdownButton(
          value: dropdownValue,
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
          },
          style: const TextStyle(
              fontFamily: 'Raleway',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
    ]);
  }
}
