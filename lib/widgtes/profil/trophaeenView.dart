import 'package:flutter/material.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/profil/eineTrophaeen.dart';
import '../../data/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learning_analytics/data/http_helper.dart';
import 'package:learning_analytics/data/trophy.dart';

class TrophaeenWidget extends StatefulWidget {
  const TrophaeenWidget({Key? key}) : super(key: key);

  @override
  State<TrophaeenWidget> createState() => _TrophaeenWidgetState();
}

class _TrophaeenWidgetState extends State<TrophaeenWidget> {
  late HttpHelper httpHelper;
  late List<Trophy> trophies = [];
  late List<OneOfAllTrophies> allTrophies = [];
  bool fetching = true;

  @override
  void initState() {
    httpHelper = HttpHelper();
    getTrophies();
    super.initState();
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
                    child: CustomAppBar(
                      title: "Meine Profil",
                      backToPage: "MeinProfilS",
                    )),
              ),
            ]),
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 48, 8, 8),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Deine Trophäen",
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            for (var oneTrophy in trophies)
                              EineTrophaee(
                                text: getTrophyDesription(
                                    allTrophies, oneTrophy.trophy),
                                tier: oneTrophy.tier,
                              ),
                          ],
                        ),
                      )),
                )),
          ]);
  }

  void getTrophies() async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    print(jwt);

    jwt ??=
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2NjY4MDkzNTksImV4cCI6MTY2NjgyMzc1OX0.hPw63fzL_GP_hYpMwuaxpYbyxqSCtw4Su91s9ge51Qk";

    List<OneOfAllTrophies> resultAllTrophies =
        await httpHelper.getAllTrophys(jwt);
    print(allTrophies);
    List<Trophy> resultGetUserTrophies = await httpHelper.getUserTrophys(jwt);

    setState(() {
      fetching = false;
      trophies = resultGetUserTrophies;
      allTrophies = resultAllTrophies;
    });
  }
}

String getTrophyDesription(
    List<OneOfAllTrophies> allTrophies, String identfier) {
  for (OneOfAllTrophies trophy in allTrophies) {
    if (trophy.identfier == identfier) {
      return trophy.description;
    }
  }
  return "no description found";
}
