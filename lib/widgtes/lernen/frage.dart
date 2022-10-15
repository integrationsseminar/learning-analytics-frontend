import 'package:flutter/material.dart';
import '../../views_s/fragen_view.dart';

class Frage extends StatefulWidget {
  Frage(
      {super.key,
      required this.frage,
      required this.tags,
      required this.answers});
  final String frage;
  final List<String> tags;
  final int answers;

  @override
  State<Frage> createState() => _FrageState();
}

class _FrageState extends State<Frage> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FragenView(),
              ));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
                width: 2.0,
                color: Theme.of(context).highlightColor,
                style: BorderStyle.solid),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(widget.frage,
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
              Card(
                  color: Theme.of(context).secondaryHeaderColor,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(children: [
                    for (var tag in widget.tags)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).highlightColor),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(tag),
                            )),
                      ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Theme.of(context).highlightColor),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.answers.toString()))),
                        ),
                      ),
                    ),
                  ])),
            ],
          ),
        ),
      );
}
