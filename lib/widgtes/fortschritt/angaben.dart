import 'package:flutter/material.dart';

class Angaben extends StatefulWidget {
  final String text;
  int selectedValue;

  Angaben({Key? key, required this.text, required this.selectedValue})
      : super(key: key);

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

  late String dropdownValue = list[widget.selectedValue];

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
            switch (value) {
              case 'Sehr hoch':
                widget.selectedValue = 0;
                break;
              case 'Hoch':
                widget.selectedValue = 1;
                break;
              case 'Mittel':
                widget.selectedValue = 2;
                break;
              case 'Gering':
                widget.selectedValue = 3;
                break;
              case 'Sehr gering':
                widget.selectedValue = 4;
                break;
            }
            print(widget.selectedValue);
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
