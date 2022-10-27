import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../data/http_helper.dart';
import '../../data/user.dart';

@immutable
class BottomMenu extends StatefulWidget {
  const BottomMenu({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  Widget build(context) {
    return FutureBuilder<String>(
        future: fetchData(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return CurvedNavigationBar(
                height: 50,
                index: widget.index,
                letIndexChange: (index) => true,
                backgroundColor: Colors.transparent,
                color: Colors.transparent,
                buttonBackgroundColor: Theme.of(context).primaryColor,
                items: [
                  Icon(Icons.account_circle, color: Colors.black),
                  Icon(Icons.menu_book_sharp, color: Colors.black),
                  Icon(
                    snapshot.data == "Student"
                        ? Icons.bar_chart
                        : Icons.add_circle_outline_outlined,
                    color: Colors.black,
                  )
                ],
                onTap: (int index) {
                  String view = '';
                  String role = snapshot.data == "Student" ? "S" : "D";
                  switch (index) {
                    case 0:
                      view = '/meinProfil$role';
                      break;
                    case 1:
                      view = '/meinLernenS';
                      break;
                    case 2:
                      view = role == "S" ? '/meinFortschrittS' : 'meineKurseD';
                      break;
                  }
                  String? currentView = ModalRoute.of(context)?.settings.name;
                  if (currentView != view) {
                    Navigator.popAndPushNamed(context, view);
                  }
                });
          }
          return Text("");
        });
  }

  Future<String> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    var role = prefs.getString("role");
    if (role == null) {
      var jwt = prefs.getString("jwt");
      jwt ??=
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2NjY4MDkzNTksImV4cCI6MTY2NjgyMzc1OX0.hPw63fzL_GP_hYpMwuaxpYbyxqSCtw4Su91s9ge51Qk";

      role = (await HttpHelper().getUser(jwt)).role;
      await prefs.setString("role", role);
    }
    return role;
  }
}
