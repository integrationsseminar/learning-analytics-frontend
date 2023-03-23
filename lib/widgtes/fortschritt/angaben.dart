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

  late String dropdownValue = list[0];

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        widget.text,
        style: Theme.of(context).textTheme.titleSmall,
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
          style: Theme.of(context).textTheme.titleSmall,
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down_rounded),
          iconSize: 15,
        ),
      ),
    ]);
  }
}
