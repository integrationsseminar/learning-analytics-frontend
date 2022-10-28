import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:learning_analytics/views_s/mein_lernen.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/profil/eineTrophaeen.dart';
import 'package:learning_analytics/widgtes/shared/divider.dart';
import 'package:learning_analytics/data/account_http_helper.dart';
import 'package:learning_analytics/data/account.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final name = TextEditingController();
  final email = TextEditingController();
  final passwort = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                      child: Text(
                        "Du hast schon einen Account?",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            height: MediaQuery.of(context).size.height * 0.05,
                            minWidth: MediaQuery.of(context).size.height * 0.15,
                            color: Theme.of(context).primaryColorLight,
                            textColor: Colors.white,
                            onPressed: () => {register()},
                            splashColor: Colors.redAccent,
                            child: Text(
                              "Registrieren",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ))));
  }

  void register() async {
    RegisterAccount newAccout =
        RegisterAccount(name.text, email.text, passwort.text, "leer");
    if (await AccountHttpHelper().postAccount(newAccout)) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const MeinLernenS()));
    }
    ;
  }
}
