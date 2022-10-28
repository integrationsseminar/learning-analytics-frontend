import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/shared/divider.dart';
import 'package:learning_analytics/widgtes/profil/trophaeenView.dart';
import 'package:learning_analytics/widgtes/profil/editierbaresItemProfil.dart';
import 'package:learning_analytics/widgtes/shared/bottom_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/user.dart';
import '../data/http_helper.dart';
import '../data/account_http_helper.dart';
import '../data/account.dart';

class MeinProfilD extends StatefulWidget {
  const MeinProfilD({Key? key}) : super(key: key);

  @override
  State<MeinProfilD> createState() => _MeinProfilDState();
}

class _MeinProfilDState extends State<MeinProfilD> {
  final username = TextEditingController(text: 'Username');
  final hochschule = TextEditingController(text: 'Deine Hochschule');
  bool fetching = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: fetching
          ? const Center(child: CircularProgressIndicator())
          : Column(children: [
              Stack(children: const [
                Positioned(
                  child: SizedBox(
                      height: 160,
                      child:
                          CustomAppBar(title: "Mein Profil", backToPage: "")),
                ),
              ]),
              Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 190,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: Theme.of(context).highlightColor,
                                      style: BorderStyle.solid,
                                      width: 3),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Username",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                            SizedBox(
                                                width: 180,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        0.0, 20.0, 20.0, 0.0),
                                                    child: SizedBox(
                                                      width: 220,
                                                      child: TextField(
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall,
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 1,
                                                        controller: username,
                                                        decoration:
                                                            const InputDecoration
                                                                    .collapsed(
                                                                hintText: ""),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          ]),
                                      const DividerWidget(),
                                      //------------------------------------------
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Hochschule",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                            SizedBox(
                                              width: 180,
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0.0, 0.0, 20.0, 0.0),
                                                  child: SizedBox(
                                                    width: 220,
                                                    child: TextField(
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall,
                                                      textAlign: TextAlign.end,
                                                      maxLines: 1,
                                                      controller: hochschule,
                                                      decoration:
                                                          const InputDecoration
                                                                  .collapsed(
                                                              hintText: ""),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),

                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 40.0, 8.0, 0.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            height: 32.0,
                                            minWidth: 120.0,
                                            color: Theme.of(context)
                                                .highlightColor,
                                            textColor: Colors.black,
                                            onPressed: () => {changeUserData()},
                                            splashColor: Colors.redAccent,
                                            child: Text(
                                              "Speichern",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ]))
            ]),
      bottomNavigationBar: BottomMenu(index: 0),
    );
  }

  void fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    jwt ??=
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2NjY4MDkzNTksImV4cCI6MTY2NjgyMzc1OX0.hPw63fzL_GP_hYpMwuaxpYbyxqSCtw4Su91s9ge51Qk";
    User initUser = await HttpHelper().getUser(jwt);
    setState(() {
      username.text = initUser.name;
      fetching = false;
    });
  }

  void changeUserData() async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");

    var account = AccountName(username.text);
    await AccountHttpHelper().changeName(account, jwt);
  }
}
