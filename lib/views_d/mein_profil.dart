import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/shared/divider.dart';
import 'package:learning_analytics/widgtes/shared/unorderedList.dart';
import 'package:learning_analytics/widgtes/profil/trophaeenView.dart';
import 'package:learning_analytics/widgtes/profil/editierbaresItemProfil.dart';
import 'package:learning_analytics/widgtes/shared/bottom_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app.dart';
import '../data/user.dart';
import '../data/http_helper.dart';
import '../data/account_http_helper.dart';
import '../data/account.dart';
import 'package:learning_analytics/widgtes/profil/profilPoint.dart';

class MeinProfilD extends StatefulWidget {
  final User user;
  const MeinProfilD({Key? key, required this.user}) : super(key: key);

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
              child: ListView(shrinkWrap: true, children: [
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
                                        content: username,
                                        field: "Username",
                                      ),
                                      const DividerWidget(),
                                      //------------------------------------------
                                      profilPoint(
                                        content: hochschule,
                                        field: "Hochschule",
                                      ),

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
                                                      BorderRadius.circular(8)),
                                              height: 32.0,
                                              minWidth: 120.0,
                                              color: Theme.of(context)
                                                  .highlightColor,
                                              textColor: Colors.black,
                                              onPressed: () =>
                                                  {changeUserData()},
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
                                                      BorderRadius.circular(8)),
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
                                    colorScheme: ColorScheme.dark(
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
                                          child: UnorderedList([
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
                      ]),
                )
              ]),
            )
          ]);
  }

  void fetchData() async {
    User initUser = widget.user;
    setState(() {
      username.text = initUser.name;
      fetching = false;
    });
  }

  void changeUserData() async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    print(jwt);

    var account = AccountLecturer(username.text, hochschule.text);
    await AccountHttpHelper().changeNameLecturer(account, jwt).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => (App(
                    currentIndex: 0,
                  ))));
    });
  }

  void logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushNamed(context, "/");
  }
}
