import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:learning_analytics/data/threadwithcomments.dart';
import 'umfrage.dart';
import 'package:learning_analytics/views_s/mein_lernen.dart';
import 'package:learning_analytics/views_s/umfragen_view.dart';
import '../../app.dart';
import '../../data/survey.dart';
import '../../views_s/fragen_view.dart';
import '../../data/threadwithcomments.dart';
import '../../data/user.dart';
import 'frage.dart';

class AnimationContainerUmfrage extends StatefulWidget {
  final User user;
  AnimationContainerUmfrage(
      {Key? key,
      required this.survey,
      required this.courseName,
      required this.user})
      : super(key: key);
  late Survey survey;
  final String courseName;

  @override
  State<AnimationContainerUmfrage> createState() =>
      _AnimationContainerUmfrageState();
}

class _AnimationContainerUmfrageState extends State<AnimationContainerUmfrage> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        closedElevation: 0,
        openElevation: 0,
        openColor: Colors.transparent,
        closedColor: Colors.transparent,
        closedShape: RoundedRectangleBorder(
            side: BorderSide.none, borderRadius: BorderRadius.circular(20)),
        openShape: RoundedRectangleBorder(
            side: BorderSide.none, borderRadius: BorderRadius.circular(20)),
        transitionType: ContainerTransitionType.fade,
        transitionDuration: const Duration(seconds: 1),
        openBuilder: (context, closeContainer) => UmfragenView(
            user: widget.user,
            survey: widget.survey,
            courseName: widget.courseName),
        onClosed: ((res) {
          print(res);
          print(widget.survey.answers.toString());
          setState(() {});
        }),
        tappable: true,
        closedBuilder: ((context, openContainer) {
          print(widget.survey.answers.toString());
          return Umfrage(
              user: widget.user,
              survey: widget.survey,
              courseName: widget.courseName);
        }));
  }
}
