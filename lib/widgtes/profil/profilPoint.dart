import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/shared/divider.dart';
import 'package:learning_analytics/widgtes/shared/unorderedList.dart';
import 'package:learning_analytics/widgtes/profil/trophaeenView.dart';
import 'package:learning_analytics/widgtes/profil/editierbaresItemProfil.dart';
import 'package:learning_analytics/widgtes/shared/bottom_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/../../data/user.dart';
import '/../../data/http_helper.dart';
import '/../../data/account_http_helper.dart';
import '/../../data/account.dart';

class profilPoint extends StatelessWidget {
  const profilPoint({
    Key? key,
    required this.content,
    required this.field,
  }) : super(key: key);

  final TextEditingController content;
  final String field;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        field,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      SizedBox(
        width: 180,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            child: SizedBox(
              width: 220,
              child: TextField(
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.end,
                maxLines: 1,
                controller: content,
                decoration: const InputDecoration.collapsed(hintText: ""),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
