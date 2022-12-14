import 'package:flutter/material.dart';
import 'package:learning_analytics/data/threadwithcomments.dart';
import '../../views_s/fragen_view.dart';
import '../../data/threadwithcomments.dart';

class Frage extends StatefulWidget {
  Frage(
      {super.key, required this.threadwithcomments, required this.courseName});
  final Threadwithcomments threadwithcomments;
  final String courseName;

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
                builder: (context) => FragenView(
                    threadwithcomments: widget.threadwithcomments,
                    courseName: widget.courseName),
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
                  child: Text(
                      textAlign: TextAlign.center,
                      widget.threadwithcomments.thread.title,
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              ),
              Card(
                  color: Theme.of(context).secondaryHeaderColor,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(children: [
                    for (var tag in [widget.courseName, "Frage"])
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).highlightColor),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(tag,
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
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
                                  child: SizedBox(
                                    width: 15,
                                    child: Text(
                                        widget.threadwithcomments.threadcomments
                                            .length
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                  ))),
                        ),
                      ),
                    ),
                  ])),
            ],
          ),
        ),
      );
}
