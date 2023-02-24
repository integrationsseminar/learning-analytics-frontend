import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../data/http_helper.dart';
import '../../data/user.dart';
import 'package:learning_analytics/views_d/mein_profil.dart';
import 'package:learning_analytics/views_d/meine_kurse.dart';

import 'package:learning_analytics/views_s/mein_lernen.dart';
import 'package:learning_analytics/views_s/mein_profil.dart';
import 'package:learning_analytics/views_s/mein_fortschritt.dart';

@immutable
class BottomMenu extends StatefulWidget {
  const BottomMenu(
      {Key? key, this.index = 1, required this.user, this.onSelectTab})
      : super(key: key);
  final int index;
  final User user;
  final onSelectTab;

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  Widget build(context) {
    return CurvedNavigationBar(
        height: 50,
        index: widget.index,
        letIndexChange: (index) => true,
        backgroundColor: Colors.transparent,
        color: Colors.transparent,
        buttonBackgroundColor: Theme.of(context).primaryColorLight,
        items: [
          Icon(Icons.account_circle, color: Colors.black),
          Icon(Icons.menu_book_sharp, color: Colors.black),
          Icon(
            widget.user.role == "Student"
                ? Icons.bar_chart
                : Icons.add_circle_outline_outlined,
            color: Colors.black,
          )
        ],
        onTap: (int index) {
          widget.onSelectTab(index);
        });
  }
}
