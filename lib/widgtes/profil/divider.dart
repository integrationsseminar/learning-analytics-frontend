import 'package:flutter/material.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/profil/angaben.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(4.0),
      child: Divider(
        height: 20,
        thickness: 1.5,
        color: Color(0xffD9D9D9),
      ),
    );
  }
}
