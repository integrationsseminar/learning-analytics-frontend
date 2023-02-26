import 'package:flutter/material.dart';
import 'package:learning_analytics/views_d/mein_profil.dart';
import 'package:learning_analytics/views_d/meine_kurse.dart';
import 'package:learning_analytics/views_s/mein_fortschritt.dart';
import 'package:learning_analytics/views_s/mein_lernen.dart';
import 'package:learning_analytics/views_s/mein_profil.dart';
import 'package:learning_analytics/widgtes/shared/bottom_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/http_helper.dart';
import 'data/user.dart';

class App extends StatefulWidget {
  int currentIndex;
  @override
  State<StatefulWidget> createState() => AppState();
  App({Key? key, required this.currentIndex}) : super(key: key);
}

class AppState extends State<App> {
  late Widget view = selectWidget();
  late User user;
  var fetching = true;
  late HttpHelper httpHelper;

  @override
  initState() {
    httpHelper = HttpHelper();
    fetchData();
    super.initState();
  }

  void _selectTab(int index) {
    setState(() {
      widget.currentIndex = index;
      view = selectWidget();
      selectWidget();
    });
  }

  Widget selectWidget() {
    if (widget.currentIndex == 0) {
      if (user.role == "Lecturer") {
        return (MeinProfilD(user: user));
      } else {
        return (MeinProfilS(user: user));
      }
    } else if (widget.currentIndex == 1) {
      return (const MeinLernenS());
    } else {
      if (user.role == "Lecturer") {
        return (const MeineKurseD());
      } else {
        return (const MeinFortschrittS());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: fetching ? const Center(child: CircularProgressIndicator()) : view,
      bottomNavigationBar: fetching
          ? Text("")
          : BottomMenu(
              index: widget.currentIndex,
              user: user,
              onSelectTab: _selectTab,
            ),
    );
  }

  void fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    jwt ??=
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2NjY4MDkzNTksImV4cCI6MTY2NjgyMzc1OX0.hPw63fzL_GP_hYpMwuaxpYbyxqSCtw4Su91s9ge51Qk";
    User initUser = await httpHelper.getUser(jwt);
    setState(() {
      user = initUser;
      fetching = false;
    });
  }
}
