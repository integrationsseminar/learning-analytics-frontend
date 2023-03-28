import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:learning_analytics/app.dart';
import 'package:learning_analytics/views/login.dart';
import 'package:learning_analytics/views_s/mein_lernen.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/profil/eineTrophaeen.dart';
import 'package:learning_analytics/widgtes/shared/divider.dart';
import 'package:learning_analytics/data/account_http_helper.dart';
import 'package:learning_analytics/data/account.dart';

class Register extends StatefulWidget {
  const Register({Key? key, this.courseId = ""}) : super(key: key);
  final courseId;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final name = TextEditingController();
  final email = TextEditingController();
  final passwort = TextEditingController();
  final kursId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name;
    final uri = Uri.parse(routeName ?? '');
    final courseId = uri.queryParameters['courseId'];

    return Scaffold(
        body: Center(
            child: Container(
                //height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                      controller: name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Name',
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
                  if (widget.courseId == "")
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 15),
                      child: TextField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        autofocus: false,
                        cursorHeight: 5,
                        style: Theme.of(context).textTheme.titleSmall,
                        controller: kursId,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Kurs-ID',
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                    child: RichText(
                      text: TextSpan(
                          text: "Du hast schon einen Account?",
                          style: Theme.of(context).textTheme.titleSmall,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Login(courseId: widget.courseId)));
                            }),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 12),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          height: MediaQuery.of(context).size.height * 0.05,
                          minWidth: MediaQuery.of(context).size.height * 0.15,
                          color: Theme.of(context).primaryColorLight,
                          textColor: Colors.white,
                          onPressed: () => {
                            register(widget.courseId != ""
                                ? widget.courseId
                                : kursId.text)
                          },
                          splashColor: Colors.redAccent,
                          child: Text(
                            "Registrieren",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      )
                    ],
                  ),
                ]))));
  }

  void register(String? courseId) async {
    RegisterAccount newAccout =
        RegisterAccount(name.text, email.text, passwort.text, "leer");
    if (await AccountHttpHelper().postAccount(newAccout, courseId)) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => App(currentIndex: 1)));
      showInSnackbar(context, "Registrierung erfolgreich", false);
    } else {
      showInSnackbar(context, "Registrierung fehlgeschlagen", false);
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
