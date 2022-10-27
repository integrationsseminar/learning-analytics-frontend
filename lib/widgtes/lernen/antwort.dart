import 'package:flutter/material.dart';

class Antwort extends StatefulWidget {
  Antwort({super.key, required this.type, required this.answer});
  final String answer;
  final bool type;

  @override
  State<Antwort> createState() => _AntwortState();
}

class _AntwortState extends State<Antwort> {
  @override
  Widget build(BuildContext context) => Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
            width: 2.0,
            color: !widget.type
                ? Theme.of(context).highlightColor
                : Theme.of(context).primaryColor,
            style: BorderStyle.solid),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(widget.answer,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium),
      ));
}
