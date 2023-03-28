import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:learning_analytics/data/threadwithcomments.dart';
import 'package:learning_analytics/views_s/mein_lernen.dart';
import '../../app.dart';
import '../../views_s/fragen_view.dart';
import '../../data/threadwithcomments.dart';
import '../../data/user.dart';
import 'frage.dart';

class AnimationContainerFrage extends StatefulWidget {
  final User user;
  AnimationContainerFrage(
      {super.key,
      required this.threadwithcomments,
      required this.courseName,
      required this.user});
  final Threadwithcomments threadwithcomments;
  final String courseName;

  @override
  State<AnimationContainerFrage> createState() =>
      _AnimationContainerFrageState();
}

class _AnimationContainerFrageState extends State<AnimationContainerFrage> {
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
        openBuilder: (_, closeContainer) => FragenView(
            user: widget.user,
            threadwithcomments: widget.threadwithcomments,
            courseName: widget.courseName),
        onClosed: (res) => setState(() {}),
        tappable: true,
        closedBuilder: (_, openContainer) => Frage(
            courseName: widget.courseName,
            threadwithcomments: widget.threadwithcomments,
            user: widget.user));
  }
}
