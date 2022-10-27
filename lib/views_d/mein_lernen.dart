import 'package:flutter/material.dart';
import 'package:learning_analytics/views_d/meine_kurse.dart';
import 'package:learning_analytics/views_s/mein_lernen.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/shared/bottom_menu.dart';

class MeinLernenD extends StatelessWidget {
  MeinLernenD({
    Key? key,
  }) : super(key: key);

  Widget meineKurseD = MeineKurseD();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomAppBar(title: "Mein Lernen", backToPage: "MeinProfilD"),
      bottomNavigationBar: BottomMenu(index: 1),
    );
  }
}
