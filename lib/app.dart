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
  var _selectedPageIndex;
  late List<Widget> _pages;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _selectedPageIndex = widget.currentIndex;

    _pageController = PageController(initialPage: _selectedPageIndex);

    httpHelper = HttpHelper();
    fetchData();
    super.initState();
  }

  late User user;
  var fetching = true;
  late HttpHelper httpHelper;

  void _selectTab(int index) {
    setState(() {
      _selectedPageIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: fetching
          ? const Center(child: CircularProgressIndicator())
          : PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: _pages,
            ),
      bottomNavigationBar: fetching
          ? Text("")
          : BottomMenu(
              index: _selectedPageIndex,
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
    user = initUser;
    _pages = [
      //The individual tabs.
    ];
    if (user.role == "Lecturer") {
      _pages.add(MeinProfilD(user: user));
    } else {
      _pages.add(MeinProfilS(user: user));
    }
    _pages.add(const MeinLernenS());

    if (user.role == "Lecturer") {
      _pages.add(const MeineKurseD());
    } else {
      _pages.add(const MeinFortschrittS());
    }

    setState(() {
      fetching = false;
    });
  }
}
