import 'package:flutter/material.dart';
import './test_view.dart';
import 'package:learning_analytics/widgtes/shared/theme.dart';

import 'views/register.dart';
import 'views/login.dart';

import './views_d/mein_lernen.dart';
import './views_d/mein_profil.dart';
import './views_d/meine_kurse.dart';

import './views_s/mein_lernen.dart';
import './views_s/mein_profil.dart';
import './views_s/mein_fortschritt.dart';

void main() {
  print("Hello, world!");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: laappTheme(),
      routes: {
        '/': (context) => const Login(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/meinLernenD': (context) => MeinLernenD(),
        '/meinProfilD': (context) => const MeinProfilD(),
        '/meineKurseD': (context) => const MeineKurseD(),
        '/meinLernenS': (context) => const MeinLernenS(),
        '/meinProfilS': (context) => const MeinProfilS(),
        '/meinFortschrittS': (context) => const MeinFortschrittS(),
      },
    );
  }
}
