import 'package:flutter/material.dart';
import '../widgtes/customappbar.dart';

class MeinFortschrittS extends StatelessWidget {
  const MeinFortschrittS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CustomAppBar(title: "Mein Lernen", backToPage: "MeinProfilD"),
    );
  }
}
