import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/shared/divider.dart';
import 'package:learning_analytics/widgtes/shared/bottom_menu.dart';
import 'package:learning_analytics/widgtes/profil/trophaeenView.dart';
import 'package:learning_analytics/widgtes/shared/unorderedList.dart';
import 'package:learning_analytics/widgtes/profil/editierbaresItemProfil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/user.dart';
import '../data/http_helper.dart';
import '../data/account_http_helper.dart';
import '../data/account.dart';
import 'package:learning_analytics/widgtes/profil/profilPoint.dart';

class MeinProfilS extends StatefulWidget {
  final User user;
  const MeinProfilS({Key? key, required this.user}) : super(key: key);

  @override
  State<MeinProfilS> createState() => _MeinProfilSState();
}

class _MeinProfilSState extends State<MeinProfilS> {
  final email = TextEditingController(text: 'Username');
  final username = TextEditingController(text: 'Username');
  final hochschule = TextEditingController(text: 'Deine Hochschule');
  final studiengang = TextEditingController(text: 'Dein Studiengang');
  final semester = TextEditingController(text: 'Dein Semester');
  final branche = TextEditingController(text: 'Deine Branche');

  bool fetching = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return fetching
        ? const Center(child: CircularProgressIndicator())
        : Column(children: [
            Stack(children: [
              Positioned(
                child: SizedBox(
                    height: 160,
                    child: CustomAppBar(title: "Mein Profil", backToPage: "")),
              ),
            ]),
            Expanded(
              child: ListView(shrinkWrap: true, children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
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
                                        profilPoint(
                                            content: email, field: "E-Mail"),
                                        const DividerWidget(),
                                        //----
                                        profilPoint(
                                            content: username,
                                            field: "Username"),
                                        const DividerWidget(),
                                        //------------------------------------------
                                        profilPoint(
                                            content: hochschule,
                                            field: "Hochschule"),
                                        const DividerWidget(),
                                        //------------------------------------------
                                        profilPoint(
                                            content: studiengang,
                                            field: "Studiengang"),
                                        const DividerWidget(),
                                        //------------------------------------------
                                        profilPoint(
                                            content: semester,
                                            field: "Semester"),
                                        const DividerWidget(),
                                        //------------------------------------------
                                        profilPoint(
                                            content: branche, field: "Branche"),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8.0, 40.0, 8.0, 12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                height: 32.0,
                                                minWidth: 120.0,
                                                color: Theme.of(context)
                                                    .highlightColor,
                                                textColor: Colors.black,
                                                onPressed: () =>
                                                    {changeUserData(context)},
                                                splashColor: Colors.redAccent,
                                                child: Text(
                                                  "Speichern",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                              ),
                                              MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                height: 32.0,
                                                minWidth: 120.0,
                                                color: Theme.of(context)
                                                    .highlightColor,
                                                textColor: Colors.black,
                                                onPressed: () => {logOut()},
                                                splashColor: Colors.redAccent,
                                                child: Text(
                                                  "Ausloggen",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 70,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: BorderSide(
                                      color: Theme.of(context).highlightColor,
                                      style: BorderStyle.solid,
                                      width: 3),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: RichText(
                                        text: TextSpan(
                                            text: "Deine Trophäen",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const TrophaeenWidget()));
                                              })),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 8, 15, 15),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                        color: Theme.of(context).highlightColor,
                                        style: BorderStyle.solid,
                                        width: 3),
                                  ),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor:
                                          Colors.black, // here for close state
                                      colorScheme: const ColorScheme.dark(
                                        primary: Colors.black,
                                      ),
                                      dividerColor: Colors.transparent,
                                    ),
                                    child: ExpansionTile(
                                        title: const Text('Netiquette'),
                                        textColor: Colors.black,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "Um einen freundlichen und gesitteten Umgang auf dieser Plattform zu gewährleisten, bitten wir Sie die folgenden Regeln zu lesen und einzuhalten!",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: UnorderedList(const [
                                              "Diskutieren Sie sachlich. Unsachliche und/oder beleidigende Kommentare haben bei uns keinen Platz.",
                                              'Wahren Sie die Regeln der Höflichkeit, wie in einem Gespräch von Angesicht zu Angesicht.',
                                              'Sehen Sie davon ab, andere persönlich zu provozieren.',
                                              'Jede Form der Diskriminierung oder Diffamierung von Menschen oder Gruppen aufgrund deren Herkunft, religiöser Zugehörigkeit, Nationalität, körperlicher Verfassung, sexueller Identität, Geschlechts, Einkommensverältnisse oder ihres Alters wird nicht akzeptiert.',
                                              'Beleidigende, volksverhetzende, ehrverletzende, pornografische, hetzerische, jugendgefährdende oder gar strafbare Äußerungen werden nicht akzeptiert.'
                                            ]),
                                          )
                                        ]),
                                  )),
                            ),
                          ),
                        ])),
              ]),
            )
          ]);
  }

  void fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    jwt ??=
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2NjY4MDkzNTksImV4cCI6MTY2NjgyMzc1OX0.hPw63fzL_GP_hYpMwuaxpYbyxqSCtw4Su91s9ge51Qk";
    print(jwt);
    User initUser = await HttpHelper().getUser(jwt);
    setState(() {
      username.text = initUser.name;
      email.text = initUser.email;
      hochschule.text = initUser.hochschule;
      studiengang.text = initUser.courseOfStudy;
      semester.text = initUser.semester;
      branche.text = initUser.branche;
      fetching = false;
    });
  }

  void changeUserData(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");

    var account = AccountStudent(username.text, email.text, hochschule.text,
        studiengang.text, semester.text, branche.text);
    bool result = await AccountHttpHelper().changeNameStudent(account, jwt);
    if (!result) {
      showInSnackbar(context, "Änderungen gespeichert", false);
    }
    ;
  }

  void logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushNamed(context, "/");
  }

  //Snackbar für Alerts
  void showInSnackbar(BuildContext context, String value, bool error) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            error ? Colors.red : Theme.of(context).primaryColorLight,
        content: Text(value),
      ),
    );
  }
}
