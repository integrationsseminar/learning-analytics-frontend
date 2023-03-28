import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:learning_analytics/app.dart';
import 'package:learning_analytics/views/register.dart';
import 'package:learning_analytics/views_s/mein_lernen.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/profil/eineTrophaeen.dart';
import 'package:learning_analytics/widgtes/shared/divider.dart';
import 'package:learning_analytics/data/account_http_helper.dart';
import 'package:learning_analytics/data/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key, this.courseId = ""}) : super(key: key);
  final courseId;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final name = TextEditingController();
  final email = TextEditingController();
  final passwort = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                width: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 15, 20, 20),
                        child: Text(
                          "Willkommen zu Learning Analytics",
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 5),
                      child: TextField(
                        autofocus: true,
                        cursorHeight: 20,
                        style: Theme.of(context).textTheme.titleSmall,
                        controller: email,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Deine E-Mail',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 15),
                      child: TextField(
                        textInputAction: TextInputAction.go,
                        onSubmitted: (value) => {login(widget.courseId)},
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        autofocus: false,
                        cursorHeight: 5,
                        style: Theme.of(context).textTheme.titleSmall,
                        controller: passwort,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Deine Passwort',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                      child: RichText(
                        text: TextSpan(
                            text: "Du hast noch keinen Account?",
                            style: Theme.of(context).textTheme.titleSmall,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register(
                                            courseId: widget.courseId)));
                              }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              height: MediaQuery.of(context).size.height * 0.05,
                              minWidth:
                                  MediaQuery.of(context).size.height * 0.15,
                              color: Theme.of(context).highlightColor,
                              textColor: Colors.black,
                              onPressed: () => {},
                              splashColor: Colors.redAccent,
                              child: Text(
                                "Passwort vergessen",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              height: MediaQuery.of(context).size.height * 0.05,
                              minWidth:
                                  MediaQuery.of(context).size.height * 0.15,
                              color: Theme.of(context).primaryColorLight,
                              textColor: Colors.white,
                              onPressed: () => {login(widget.courseId)},
                              splashColor: Colors.redAccent,
                              child: Text(
                                "Einloggen",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ))));
  }

  void login(String? courseId) async {
    Account account = Account(email.text, passwort.text);
    if (await AccountHttpHelper().loginAccount(account, courseId)) {
      showInSnackbar(context, "Login erfolgreich", false);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => App(currentIndex: 1)));
    } else {
      showInSnackbar(context, "Anmeldedaten falsch", true);
    }
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
